part of '../language_pattern.dart';

/// {@template fr_pattern}
/// French profanity pattern.
///  {@endtemplate}
final class FrPattern implements LanguagePattern {
  /// {@macro fr_pattern}
  const FrPattern();

  @override
  String get name => 'french';

  @override
  String get locale => 'fr';

  @override
  RegExp get regExp => RegExp(
        '(?<![A-Za-zÀ-ÖØ-öø-ÿ])'
        '(?:'
        r'fils\s*de\s*pute' // fils de pute
        '|putain[A-Za-zÀ-ÖØ-öø-ÿ]*' // putain, putains...
        '|pute[A-Za-zÀ-ÖØ-öø-ÿ]*' // pute, putes...
        '|niqu[eé][A-Za-zÀ-ÖØ-öø-ÿ]*' // nique, niqué, niquer...
        '|encul[eé][A-Za-zÀ-ÖØ-öø-ÿ]*' // enculé, enculer...
        '|connard[A-Za-zÀ-ÖØ-öø-ÿ]*' // connard, connards...
        '|connass[A-Za-zÀ-ÖØ-öø-ÿ]*' // connasse, connasses...
        '|salope[A-Za-zÀ-ÖØ-öø-ÿ]*' // salope, salopes...
        '|b[âa]tard[A-Za-zÀ-ÖØ-öø-ÿ]*' // bâtard, batard...
        ')'
        '(?![A-Za-zÀ-ÖØ-öø-ÿ])',
        unicode: true,
        caseSensitive: false,
      );
}
