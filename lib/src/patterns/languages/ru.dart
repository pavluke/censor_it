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

  @override
  RegExp get regExp {
    const prefixes = '(?:о[бт]?|за|на|от|под|пере|про|раз|вз|из|с|у|до|вы)';

    return RegExp(
      '(?<![а-яё])'
      '(?:'
      // хуй и производные
      '$prefixes'
      'ъ?ху[йеёиыяю][а-яёъь]*'
      '|ху[йеёиыяю][а-яёъь]*'
      '|'
      '$prefixes'
      'ъ?пизд[а-яёъь]*'
      '|пизд[а-яёъь]*'
      '|'
      '$prefixes'
      'ъ?[её]б[а-яёъь]*'
      '|[её]б[а-яёъь]*'
      '|'
      '$prefixes'
      'ъ?бляд[а-яёъь]*'
      '|бляд[а-яёъь]*'
      '|гандон[а-яёъь]*'
      ')'
      '(?![а-яё])',
      caseSensitive: false,
      unicode: true,
    );
  }
}
