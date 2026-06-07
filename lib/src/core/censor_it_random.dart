import 'dart:math' show Random;

import 'package:collection/collection.dart';

import 'censor_it_base.dart';

/// {@template censor_it_random}
/// Creates an instance with random character replacement.
///
/// [text] is the text to be censored.
/// [pattern] is the censor pattern to use.
/// Defaults to [LanguagePattern.all].
/// [chars] is the list of characters to use for censoring.
/// Defaults to [CensorItRandom.defaultChars].
///
/// Example:
/// ```
/// final censor = CensorIt.random(
///   'fuck this shit',
///   pattern: LanguagePattern.english,
///   chars: ['*', '#', '@'],
/// );
/// print(censor.censored); // '*#@* this @#*#'
/// ```
/// {@endtemplate}

final class CensorItRandom extends CensorIt {
  /// {@macro censor_it_random}
  CensorItRandom(
    super.text, {
    super.pattern,
    List<String>? chars,
  }) : chars = chars ?? defaultChars {
    if (this.chars.isEmpty) {
      throw ArgumentError('chars must not be empty');
    }

    if (this.chars.any((c) => c.length != 1)) {
      throw ArgumentError('Each char must be a single character');
    }
  }

  /// Default characters used for censoring profanity.
  static const List<String> defaultChars = [
    '!',
    '#',
    '%',
    '&',
    '?',
    '@',
    r'$',
  ];

  /// The list of characters to use for censoring.
  final List<String> chars;

  @override
  String replacer(String word) {
    throw UnsupportedError(
      'CensorItRandom uses custom logic, use censored getter instead',
    );
  }

  String? _cachedRandomCensored;

  /// The censored text with profanity replaced by random characters.
  ///
  /// The result is cached after first access.
  @override
  String get censored =>
      _cachedRandomCensored ??= _generateRandomCensoredText();

  static const _maxAttempts = 100;

  String _generateRandomCensoredText() {
    if (original.isEmpty) return '';

    final regExp = pattern.regExp;
    final random = Random();

    final censoredText = original.replaceAllMapped(regExp, (match) {
      final original = match[0] ?? '';
      if (original.isEmpty) return '';

      final usedChars = <String>{};
      String lastChar = '';

      final replacement = List<String>.generate(original.length, (index) {
        if (chars.length == 1) {
          return chars[0];
        }

        String char;
        int attempts = 0;
        do {
          char = chars.elementAt(random.nextInt(chars.length));
          attempts++;
          if (attempts > _maxAttempts) {
            char = chars.firstWhere(
              (c) => c != lastChar,
              orElse: () => chars[0],
            );
            break;
          }
        } while (char == lastChar ||
            (index == 0 && char == '!') ||
            (index == original.length - 1 && char == '?'));

        lastChar = char;
        usedChars.add(char);
        return char;
      });

      if (chars.length > 1 &&
          usedChars.length < chars.length &&
          original.length > chars.length) {
        final unusedChars = chars.toSet().difference(usedChars).toList();
        if (unusedChars.isNotEmpty) {
          final unusedChar = unusedChars[random.nextInt(unusedChars.length)];
          int unusedCharIndex;
          int attempts = 0;
          do {
            unusedCharIndex = random.nextInt(replacement.length);
            attempts++;
            if (attempts > _maxAttempts) break;
          } while ((replacement[unusedCharIndex] == lastChar ||
                  (unusedCharIndex == 0 && unusedChar == '!') ||
                  (unusedCharIndex == replacement.length - 1 &&
                      unusedChar == '?')) &&
              attempts < _maxAttempts);

          replacement[unusedCharIndex] = unusedChar;
        }
      }

      final result = StringBuffer();
      for (int i = 0; i < original.length; i++) {
        final originalChar = original[i];
        final replacementChar = replacement[i];
        result.write(
          originalChar.toUpperCase() == originalChar
              ? replacementChar.toUpperCase()
              : replacementChar.toLowerCase(),
        );
      }

      return result.toString();
    });

    return censoredText;
  }

  /// Creates a new [CensorItRandom] instance with regenerated censored text.
  ///
  /// Returns a new instance with different random censoring applied
  /// to the same [original] text. Attempts up to 10 times to ensure
  /// the new censored text is different from the current one.
  ///
  /// Example:
  /// ```dart
  /// final censor1 = CensorItRandom('shit');
  /// print(censor1.censored); // '@#!%'
  ///
  /// final censor2 = censor1.regenerate();
  /// print(censor2.censored); // '#%!@' (guaranteed different)
  /// ```
  CensorItRandom regenerate() {
    if (!hasProfanity || original.isEmpty || chars.length == 1) {
      return CensorItRandom(original, pattern: pattern, chars: chars);
    }

    const maxAttempts = 10;
    final currentCensored = censored;

    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      final newInstance = CensorItRandom(
        original,
        pattern: pattern,
        chars: chars,
      );

      if (newInstance.censored != currentCensored) {
        return newInstance;
      }
    }

    return CensorItRandom(original, pattern: pattern, chars: chars);
  }

  @override
  bool operator ==(Object other) {
    if (other is CensorItRandom) {
      return original == other.original &&
          pattern == other.pattern &&
          const ListEquality().equals(chars, other.chars);
    }
    return false;
  }

  @override
  int get hashCode => original.hashCode ^ pattern.hashCode ^ chars.hashCode;

  @override
  String toString() =>
      '''CensorItRandom(original: $original, censored: $censored, chars: $chars, pattern: $pattern)''';
}
