part of '../language_pattern.dart';

/// {@template lt_pattern}
/// Lithuanian profanity pattern.
///  {@endtemplate}
final class LtPattern implements LanguagePattern {
  /// {@macro lt_pattern}
  const LtPattern();

  @override
  String get name => 'lithuanian';

  @override
  String get locale => 'lt';

  static final RegExp _regExp = RegExp(
        '(?<![a-ząčęėįšųūž])'
        '(?:'
        'byb[a-ząčęėįšųūž]*'
        '|pizd[a-ząčęėįšųūž]*'
        '|nahu(?:i|j)[a-ząčęėįšųūž]*'
        '|blet[a-ząčęėįšųūž]*'
        ')'
        '(?![a-ząčęėįšųūž])',
        caseSensitive: false,
        unicode: true,
      );

  @override
  RegExp get regExp => _regExp;
}
