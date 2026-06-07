part of '../language_pattern.dart';

/// {@template kk_pattern}
/// Kazakh profanity pattern.
///  {@endtemplate}
final class KkPattern implements LanguagePattern {
  /// {@macro kk_pattern}
  const KkPattern();

  @override
  String get name => 'kazakh';

  @override
  String get locale => 'kk';

  @override
  RegExp get regExp => RegExp(
        '(?<![а-яёәғқңөұүһі])'
        '(?:'
        'қотақ[а-яёәғқңөұүһі]*' // қотақ, қотақты, қотақтың …
        '|боқ[а-яёәғқңөұүһі]*' // боқ, боқты, боқтың …
        '|анаң[а-яёәғқңөұүһі]*' // анаңды, анаңның …
        '|шешең[а-яёәғқңөұүһі]*' // шешеңді, шешеңнің …
        ')'
        '(?![а-яёәғқңөұүһі])',
        caseSensitive: false,
        unicode: true,
      );
}
