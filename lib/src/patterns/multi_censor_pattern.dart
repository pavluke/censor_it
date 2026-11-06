import 'censor_pattern.dart';

/// Internal class for multiple language patterns.
///
/// This class is used internally by [LanguagePattern.fromLocales].
/// Use [CensorPattern.multi] or [LanguagePattern.all] instead.
final class MultiCensorPattern implements CensorPattern {
  /// {@template multi_censor_pattern_constructor}
  /// Creates a multi-language pattern from a list of patterns.
  ///
  /// An empty [patterns] list is a pattern that matches nothing
  /// (it never reports profanity).
  ///
  /// [patterns] is treated as immutable: the combined [regExp] is built
  /// once per instance and cached.
  ///
  /// Example:
  /// ```
  /// // Don't use directly, use factory instead:
  /// final pattern = CensorPattern.multi([
  ///   LanguagePattern.english,
  ///   LanguagePattern.spanish,
  /// ]);
  /// final censor = CensorIt.random('fuck puta', pattern: pattern);
  /// ```
  /// {@endtemplate}
  const MultiCensorPattern(this.patterns);

  /// The list of combined patterns.
  final List<CensorPattern> patterns;

  /// {@macro censor_pattern_regexp_getter}
  ///
  /// The resulting regex uses non-capturing groups and combines
  /// all pattern sources with OR operator (|).
  /// The regex is case-insensitive and Unicode-aware.
  ///
  /// The result is built on first access and cached per instance.
  /// For an empty [patterns] list a regex that never matches is returned
  /// (a plain `(?:)` would match an empty string at every position).
  @override
  RegExp get regExp => _cache[this] ??= _build();

  RegExp _build() {
    if (patterns.isEmpty) return _neverMatches;

    final sources = patterns.map((p) => p.regExp.pattern).toList();
    final combined = '(?:${sources.join('|')})';
    return RegExp(
      combined,
      caseSensitive: false,
      unicode: true,
    );
  }

  // The class is `const`, so it cannot hold a lazily computed field.
  // An [Expando] gives the same per-instance cache without keeping
  // instances alive.
  static final Expando<RegExp> _cache = Expando<RegExp>(
    'MultiCensorPattern.regExp',
  );

  /// Matches nothing: the negative lookahead of an empty pattern always fails.
  static final RegExp _neverMatches = RegExp('(?!)');
}
