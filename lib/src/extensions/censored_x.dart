import '../src.dart';

/// {@template censored_x.class}
/// Returns the censored version of this string using random characters.
///
/// [pattern] is the censor pattern to use.
/// Defaults to [LanguagePattern.all].
///
/// Example:
/// ```dart
/// print('fuck this'.censor(pattern: LanguagePattern.english));
/// ```
/// {@endtemplate}
extension CensoredX on String {
  /// {@macro censored_x.class}
  String censor({
    CensorPattern pattern = LanguagePattern.all,
  }) => CensorIt.random(this, pattern: pattern).censored;

  /// Use [censor] instead.
  @Deprecated(
    'Use censor() instead. Will be removed in the next major version.',
  )
  String censored({
    CensorPattern pattern = LanguagePattern.all,
  }) => censor(pattern: pattern);
}
