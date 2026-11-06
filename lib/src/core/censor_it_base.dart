import '../src.dart';

/// Signature for custom replacement function.
typedef ReplacementBuilder = String Function(String word);

/// {@template censor_pattern_param}
/// [pattern] is the censor pattern to use.
/// Defaults to [LanguagePattern.all].
/// {@endtemplate}
///
/// {@template censor_text_param}
/// [text] is the text to be censored.
/// {@endtemplate}
///
/// {@macro censor_example_random}

abstract class CensorIt {
  /// Abstract [CensorIt] constructor.
  ///
  /// {@macro censor_text_param}
  /// {@macro censor_pattern_param}
  CensorIt(
    this._text, {
    this._pattern = LanguagePattern.all,
  });

  /// {@macro censor_it_random}
  static CensorItRandom random(
    String text, {
    CensorPattern pattern = LanguagePattern.all,
    List<String>? chars,
  }) => CensorItRandom(text, pattern: pattern, chars: chars);

  ///{@macro censor_it_builder}
  static CensorItBuilder builder(
    String text, {
    required ReplacementBuilder builder,
    CensorPattern pattern = LanguagePattern.all,
  }) => CensorItBuilder(text, builder: builder, pattern: pattern);

  /// {@macro censor_it_mask}
  static CensorIt mask(
    String text, {
    String char = '*',
    CensorPattern pattern = LanguagePattern.all,
  }) => CensorItMask(text, char: char, pattern: pattern);

  ///  {@macro censor_it_replace}
  static CensorItReplace replace(
    String text, {
    required String replacement,
    CensorPattern pattern = LanguagePattern.all,
  }) => CensorItReplace(text, replacement: replacement, pattern: pattern);

  final String _text;

  /// The original text.
  String get original => _text;

  final CensorPattern _pattern;

  /// The censor pattern.
  CensorPattern get pattern => _pattern;

  /// Abstract method that subclasses must implement to provide
  /// the replacement logic for profane words.
  String replacer(String word);

  String? _cachedCensored;

  /// The censored text with profanity replaced.
  ///
  /// The result is cached after first access.
  String get censored => _cachedCensored ??= _generateCensoredText();

  String _generateCensoredText() {
    if (original.isEmpty) return '';
    return original.replaceAllMapped(pattern.regExp, (match) {
      final matchedWord = match[0] ?? '';
      if (matchedWord.isEmpty) return '';
      final replacement = replacer(matchedWord);
      if (replacement.isNotEmpty && matchedWord.isNotEmpty) {
        if (matchedWord[0].toUpperCase() == matchedWord[0]) {
          return replacement[0].toUpperCase() +
              (replacement.length > 1 ? replacement.substring(1) : '');
        }
      }
      return replacement;
    });
  }

  /// Checks if the text contains any profanity based on the censor pattern.
  ///
  /// Returns `true` if at least one profanity word is found, `false` otherwise.
  bool get hasProfanity => GetMatchesX(this).matches.isNotEmpty;

  /// Returns a list of swear words found in the text.
  ///
  /// The words are returned in lowercase and in the order they appear.
  List<String> get swearWords =>
      GetMatchesX(this).matches.map((match) => match.group(0) ?? '').toList();

  @override
  int get hashCode => Object.hash(original, pattern);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CensorIt) return false;
    return other.original == original && other.pattern == pattern;
  }
}
