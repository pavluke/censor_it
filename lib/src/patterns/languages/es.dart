part of '../language_pattern.dart';

/// {@template es_pattern}
/// Spanish profanity pattern.
///  {@endtemplate}
final class EsPattern implements LanguagePattern {
  /// {@macro es_pattern}
  const EsPattern();
  @override
  String get name => 'spanish';

  @override
  String get locale => 'es';

  @override
  RegExp get regExp => RegExp(
        '(?<![a-záéíóúñü])'
        '(?:'
        r'hijo?s?\s*de\s*puta' // hijo de puta / hijos de puta
        '|cabr(?:o|ó)n[a-záéíóúñü]*' // cabrón, cabronazos…
        '|gilipollas' // gilipollas
        '|put[ao][a-záéíóúñü]*' // puta, putos, putear…
        '|ching[a-záéíóúñü]*' // chinga, chingar, chingado…
        '|culer(?:o|os)[a-záéíóúñü]*' // culero, culeros
        '|verg(?:a|as)[a-záéíóúñü]*' // verga, vergas
        '|coñ(?:o|os)[a-záéíóúñü]*' // coño, coños
        ')'
        '(?![a-záéíóúñü])',
        caseSensitive: false,
        unicode: true,
      );
}
