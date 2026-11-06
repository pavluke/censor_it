part of '../language_pattern.dart';

/// {@template ru_pattern}
/// Russian profanity pattern.
///  {@endtemplate}
final class RuPattern implements LanguagePattern {
  /// {@macro ru_pattern}
  const RuPattern();
  @override
  String get name => 'russian';

  @override
  String get locale => 'ru';

  static const _prefixes =
      '(?:о[бт]?|за|на|от|под|пере|про|раз|вз|из|с|у|до|вы)';

  /// Prefixes for the "еб" root.
  ///
  /// The bare prefix "с" is intentionally excluded: it would turn
  /// the ordinary words "себя", "себе", "себестоимость" into profanity.
  /// Forms like "съебать" are still caught by `с(?=ъ)`.
  static const _ebPrefixes =
      '(?:о[бт]?|за|на|от|под|пере|про|раз|вз|из|у|до|вы|с(?=ъ))';

  static final RegExp _regExp = RegExp(
    '(?<![а-яё])'
    '(?:'
    // хуй и производные
    '$_prefixes'
    'ъ?ху[йеёиыяю][а-яёъь]*'
    '|ху[йеёиыяю][а-яёъь]*'
    '|'
    '$_prefixes'
    'ъ?пизд[а-яёъь]*'
    '|пизд[а-яёъь]*'
    '|'
    '$_ebPrefixes'
    'ъ?[её]б[а-яёъь]*'
    '|[её]б[а-яёъь]*'
    '|'
    '$_prefixes'
    'ъ?бляд[а-яёъь]*'
    '|бляд[а-яёъь]*'
    '|гандон[а-яёъь]*'
    ')'
    '(?![а-яё])',
    caseSensitive: false,
    unicode: true,
  );

  @override
  RegExp get regExp => _regExp;
}
