part of '../language_pattern.dart';

/// {@template uk_pattern}
/// Ukrainian profanity pattern.
///  {@endtemplate}
final class UkPattern implements LanguagePattern {
  /// {@macro uk_pattern}
  const UkPattern();

  @override
  String get name => 'ukrainian';

  @override
  String get locale => 'uk';

  @override
  RegExp get regExp => RegExp(
        '(?<![а-яіїєґ])'
        '(?:'
        'ху[йяєїео][а-яіїєґ]*'
        '|п[іи]зд[а-яіїєґ]*'
        '|(?:[еєї]б|йоб)[а-яіїєґ]*'
        '|бляд[а-яіїєґ]*'
        ')'
        '(?![а-яіїєґ])',
        caseSensitive: false,
        unicode: true,
      );
}
