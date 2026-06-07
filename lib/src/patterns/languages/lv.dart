part of '../language_pattern.dart';

/// {@template lv_pattern}
/// Latvian profanity pattern.
///  {@endtemplate}
final class LvPattern implements LanguagePattern {
  /// {@macro lv_pattern}
  const LvPattern();

  @override
  String get name => 'latvian';

  @override
  String get locale => 'lv';

  @override
  RegExp get regExp => RegExp(
        '(?<![a-zāčēģīķļņšūž])'
        '(?:'
        'pis[a-zāčēģīķļņšūž]*'
        '|pizd[a-zāčēģīķļņšūž]*'
        '|dir[sš][a-zāčēģīķļņšūž]*'
        '|pimp[a-zāčēģīķļņšūž]*'
        '|mauk(?:'
        'a(?:s|m)?'
        '|ai'
        '|ām'
        '|u|us'
        '|i|iem'
        '|īt(?:e|es)?'
        '))'
        '(?![a-zāčēģīķļņšūž])',
        caseSensitive: false,
        unicode: true,
      );
}
