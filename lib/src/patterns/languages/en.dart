part of '../language_pattern.dart';

/// {@template en_pattern}
/// English profanity pattern.
///  {@endtemplate}
final class EnPattern implements LanguagePattern {
  /// {@macro en_pattern}
  const EnPattern();
  @override
  String get name => 'english';

  @override
  String get locale => 'en';

  @override
  RegExp get regExp => RegExp(
        '(?<![a-z])'
        '(?:'
        'motherfucker' // motherfucker
        '|fuck(?:er|ing|ed|s)?' // fuck, fucker, fucking, …
        '|bullshit' // bullshit
        '|shit(?:head|ty)?' // shit, shitty, shithead
        '|asshole' // asshole
        '|dick(?:head)?' // dick, dickhead
        '|cock' // cock
        '|bastard' // bastard
        '|slut(?:s)?' // slut, sluts
        '|whore(?:s)?' // whore, whores
        ')'
        '(?![a-z])', // right: not a letter (or end)
        caseSensitive: false,
      );
}
