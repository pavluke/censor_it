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

  @override
  RegExp get regExp => RegExp(
        '(?<![a-zåäö])'
        '(?:'
        'fitt[a-zåäö]*'
        '|kuk(?:'
        '|en'
        '|ar(?:na)?'
        '|s'
        ')'
        '|knull[a-zåäö]*'
        '|hor[a-zåäö]*'
        ')'
        '(?![a-zåäö])',
        caseSensitive: false,
        unicode: true,
      );
}
