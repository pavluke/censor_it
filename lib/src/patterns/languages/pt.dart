part of '../language_pattern.dart';

/// {@template pt_pattern}
/// Portuguese profanity pattern.
///  {@endtemplate}
final class PtPattern implements LanguagePattern {
  /// {@macro pt_pattern}
  const PtPattern();

  @override
  String get name => 'portuguese';

  @override
  String get locale => 'pt';

  @override
  RegExp get regExp => RegExp(
        '(?<![a-záàâãçéêíóôõúü])'
        '(?:'
        r'filhos?\s*da\s*puta'
        '|caralh[a-záàâãçéêíóôõúü]*'
        '|fod[a-záàâãçéêíóôõúü-]*'
        '|porr[a-záàâãçéêíóôõúü]*'
        '|puta[a-záàâãçéêíóôõúü]*'
        '|merd[a-záàâãçéêíóôõúü]*'
        '|cu(?:z[aã]o|zon[aã])?[a-záàâãçéêíóôõúü]*'
        ')'
        '(?![a-záàâãçéêíóôõúü])',
        caseSensitive: false,
        unicode: true,
      );
}
