part of '../language_pattern.dart';

/// {@template pl_pattern}
/// Polish profanity pattern.
///  {@endtemplate}
final class PlPattern implements LanguagePattern {
  /// {@macro pl_pattern}
  const PlPattern();

  @override
  String get name => 'polish';

  @override
  String get locale => 'pl';

  @override
  RegExp get regExp => RegExp(
        '(?<![a-ząćęłńóśźż])'
        '(?:'
        'kurw[a-ząćęłńóśźż]*'
        '|skurw[a-ząćęłńóśźż]*'
        '|chuj[a-ząćęłńóśźż]*'
        '|jeb[a-ząćęłńóśźż]*'
        '|pierdol[a-ząćęłńóśźż]*'
        '|pizd[a-ząćęłńóśźż]*'
        ')'
        '(?![a-ząćęłńóśźż])',
        caseSensitive: false,
        unicode: true,
      );
}
