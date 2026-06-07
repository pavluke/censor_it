part of '../language_pattern.dart';

/// {@template fi_pattern}
/// Finnish profanity pattern.
///  {@endtemplate}
final class FiPattern implements LanguagePattern {
  /// {@macro fi_pattern}
  const FiPattern();
  @override
  String get name => 'finnish';

  @override
  String get locale => 'fi';

  @override
  RegExp get regExp => RegExp(
        '(?<![A-Za-zÀ-ÖØ-öø-ÿ])'
        '(?:'
        'vit{1,2}[a-zåäö]*' // vittu, vitun, vittua, vittuun...
        '|(?:kyrp|kyrv)[aä][a-zåäö]*' // kyrpä, kyrpää, kyrvän...
        '|pillu[a-zåäö]*' // pillu, pillun, pilluja...
        '|huor[a-zåäö]*' // huora, huorat, huoran...
        ')'
        '(?![A-Za-zÀ-ÖØ-öø-ÿ])',
        caseSensitive: false,
        unicode: true,
      );
}
