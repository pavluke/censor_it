part of '../language_pattern.dart';

/// {@template de_pattern}
/// German profanity pattern.
///  {@endtemplate}
final class DePattern implements LanguagePattern {
  /// {@macro de_pattern}
  const DePattern();
  @override
  String get name => 'german';

  @override
  String get locale => 'de';

  @override
  RegExp get regExp => RegExp(
        '(?<![a-zäöüß])'
        '(?:'
        '(?:ver)?fick(?:'
        '|en' // ficken
        '|st' // fickst
        '|t' // fickt
        '|e' // ficke
        '|er?s?' // ficker, fickers
        '|te' // fickte
        '|test' // ficktest
        '|tet' // ficktet
        '|st?e?n?' // gefickt / verfickt
        ')'
        '|schei(?:ß|ss)(?:e|er|t|lich|dreck)?' // scheiße & Co.
        '|arschloch'
        '|drecksau'
        '|hurensohn'
        '|fotze(?:n)?'
        '|wichser'
        ')'
        '(?![a-zäöüß])',
        caseSensitive: false,
        unicode: true,
      );
}
