import 'censor_it_base.dart';

/// {@template censor_it_replace}
/// Creates an instance that replaces profanity with a fixed string.
///
/// [text] is the text to be censored.
/// [replacement] is the string to replace profanity with.
/// [pattern] is the censor pattern to use.
/// Defaults to [LanguagePattern.all].
///
/// Example:
/// ```
/// final censor = CensorIt.replace(
///   'fuck this shit',
///   replacement: '[censored]',
///   pattern: LanguagePattern.english,
/// );
/// print(censor.censored); // '[censored] this [censored]'
/// ```
/// {@endtemplate}
final class CensorItReplace extends CensorIt {
  ///  {@macro censor_it_replace}
  CensorItReplace(
    super.text, {
    required this._replacement,
    super.pattern,
  });

  final String _replacement;

  @override
  String replacer(String word) => _replacement;

  /// Returns `true` if [original], [pattern], and [_replacement] of both
  /// instances are the same.
  @override
  bool operator ==(Object other) {
    if (other is CensorItReplace) {
      return original == other.original &&
          pattern == other.pattern &&
          _replacement == other._replacement;
    }
    return false;
  }

  @override
  int get hashCode =>
      original.hashCode ^ pattern.hashCode ^ _replacement.hashCode;

  @override
  String toString() =>
      '''CensorItReplace(original: $original, censored: $censored, replacement: $_replacement, pattern: $pattern)''';
}
