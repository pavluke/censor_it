import 'censor_it_base.dart';

/// {@template censor_it_builder}
/// Creates an instance with custom replacement function.
///
/// [text] is the text to be censored.
/// [builder] is the function that takes a profanity word and returns
/// its replacement.
/// [pattern] is the censor pattern to use.
/// Defaults to [LanguagePattern.all].
///
/// Example:
/// ```
/// final censor = CensorIt.builder(
///   'fucking shit',
///   builder: (word) => word.length <= 4 ? '💩' : '🤬',
///   pattern: LanguagePattern.english,
/// );
/// print(censor.censored); // '🤬 💩'
/// ```
/// {@endtemplate}
///
final class CensorItBuilder extends CensorIt {
  /// {@macro censor_it_builder}
  CensorItBuilder(
    super.text, {
    required ReplacementBuilder builder,
    super.pattern,
  }) : _builder = builder;

  final ReplacementBuilder _builder;

  @override
  String replacer(String word) => _builder(word);

  @override
  bool operator ==(Object other) {
    if (other is CensorItBuilder) {
      return original == other.original && pattern == other.pattern;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(original, pattern, _builder);

  @override
  String toString() =>
      '''CensorItBuilder(original: $original, censored: $censored, pattern: $pattern)''';
}
