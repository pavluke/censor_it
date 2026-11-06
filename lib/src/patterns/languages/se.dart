part of '../language_pattern.dart';

/// {@template sv_pattern}
/// Swedish profanity pattern.
///  {@endtemplate}
final class SvPattern implements LanguagePattern {
  /// {@macro sv_pattern}
  const SvPattern();

  @override
  String get name => 'swedish';

  @override
  String get locale => 'sv';

  static final RegExp _regExp = RegExp(
        '(?<![a-zåäö])'
        '(?:'
        'fitt[a-zåäö]*'
        '|kuk(?:'
        '|en'
        '|ar(?:na)?'
        '|s'
        ')'
        '|knull[a-zåäö]*'
        '|hor(?:a|an|ar|arna|or|orna|unge|ungen|ungar|ungarna)'
        ')'
        '(?![a-zåäö])',
        caseSensitive: false,
        unicode: true,
      );

  @override
  RegExp get regExp => _regExp;
}
