import '../src.dart';

final Expando<List<RegExpMatch>> _matchesCache = Expando<List<RegExpMatch>>(
  'CensorIt.matches',
);

/// Extension for getting regex matches from [CensorIt].
extension GetMatchesX on CensorIt {
  /// Returns all regex matches found in the original text.
  ///
  /// The text is converted to lowercase before matching.
  ///
  /// Example:
  /// ```dart
  /// final censor = CensorIt.random(
  ///   'fuck this shit bastard',
  ///   pattern: LanguagePattern.english,
  /// );
  /// final matches = censor.matches;
  /// print(matches.length); // 3
  /// ```
  ///
  /// The matches are computed once per [CensorIt] instance and cached.
  /// The returned list is unmodifiable.
  List<RegExpMatch> get matches => _matchesCache[this] ??= List.unmodifiable(
    pattern.regExp.allMatches(original.toLowerCase()),
  );
}
