import 'censor_pattern.dart';

part 'languages/de.dart';
part 'languages/en.dart';
part 'languages/es.dart';
part 'languages/fi.dart';
part 'languages/fr.dart';
part 'languages/it.dart';
part 'languages/kk.dart';
part 'languages/ko.dart';
part 'languages/lt.dart';
part 'languages/lv.dart';
part 'languages/pl.dart';
part 'languages/pt.dart';
part 'languages/ru.dart';
part 'languages/se.dart';
part 'languages/uk.dart';
part 'languages/zh.dart';

/// Base class for language-specific censor patterns.
///
/// This class is sealed - only predefined language patterns can exist.
/// Use [LanguagePattern.fromLocale] to get a pattern by locale code.
///
/// {@template language_pattern_example}
/// Example:
/// ```dart
/// final latvian = LanguagePattern.fromLocale('lv');
/// print(latvian.locale); // 'lv'
///
/// final censor = CensorIt.random(
///   'fuck this shit',
///   pattern: LanguagePattern.english,
/// );
/// ```
/// {@endtemplate}
sealed class LanguagePattern implements CensorPattern {
  /// {@macro language_pattern_example}
  const LanguagePattern();

  /// Locale code (e.g., 'en', 'ru', 'lv').
  String get locale;

  /// Human-readable language name.
  String get name;

  /// Gets a language pattern by locale code.
  ///
  /// Returns [fallback] if locale is not found.
  /// Defaults to English if no fallback is provided.
  ///
  /// Example:
  /// ```dart
  /// final pattern = LanguagePattern.fromLocale('lv');
  /// final withFallback = LanguagePattern.fromLocale(
  ///   'unknown',
  ///   fallback: LanguagePattern.english,
  /// );
  /// final censor = CensorIt.mask('fuck this shit', pattern: pattern);
  /// ```
  static LanguagePattern fromLocale(
    String locale, {
    LanguagePattern fallback = LanguagePattern.english,
  }) =>
      values.firstWhere(
        (e) => e.locale == locale,
        orElse: () => fallback,
      );

  /// Creates a combined pattern from multiple locale codes.
  ///
  /// Example:
  /// ```dart
  /// final pattern = LanguagePattern.fromLocales(['en', 'es']);
  /// final censor = CensorIt.random(
  ///   'fuck you puta',
  ///   pattern: pattern,
  /// );
  /// ```
  static CensorPattern fromLocales(
    List<String> locales, {
    List<LanguagePattern>? fallback,
  }) {
    final effectiveFallback = fallback ?? values;

    if (locales.isEmpty) return _combine(effectiveFallback);

    final matchedPatterns = <LanguagePattern>{};

    for (final locale in locales) {
      final found = values.firstWhere(
        (pattern) => pattern.locale == locale,
        orElse: () => effectiveFallback.first,
      );
      matchedPatterns.add(found);
    }

    final patternsToCombine = matchedPatterns.isNotEmpty
        ? matchedPatterns.toList()
        : effectiveFallback;

    return _combine(patternsToCombine);
  }

  /// Combines [patterns] into one pattern.
  ///
  /// Combined patterns are memoized by locale set, so calling
  /// [fromLocales] on every widget build does not recompile the regex.
  static CensorPattern _combine(List<LanguagePattern> patterns) {
    if (patterns.length == 1) return patterns.first;

    final key = patterns.map((p) => p.locale).join(',');
    return _combined.putIfAbsent(
      key,
      () => CensorPattern.multi(List.unmodifiable(patterns)),
    );
  }

  static final Map<String, CensorPattern> _combined = {};

  /// {@macro zh_pattern}
  static const LanguagePattern chinese = ZhPattern();

  /// {@macro en_pattern}
  static const LanguagePattern english = EnPattern();

  /// {@macro fi_pattern}
  static const LanguagePattern finnish = FiPattern();

  /// {@macro fr_pattern}
  static const LanguagePattern french = FrPattern();

  /// {@macro it_pattern}
  static const LanguagePattern italian = ItPattern();

  /// {@macro de_pattern}
  static const LanguagePattern german = DePattern();

  /// {@macro kk_pattern}
  static const LanguagePattern kazakh = KkPattern();

  /// {@macro ko_pattern}
  static const LanguagePattern korean = KoPattern();

  /// {@macro lt_pattern}
  static const LanguagePattern lithuanian = LtPattern();

  /// {@macro lv_pattern}
  static const LanguagePattern latvian = LvPattern();

  /// {@macro pl_pattern}
  static const LanguagePattern polish = PlPattern();

  /// {@macro pt_pattern}
  static const LanguagePattern portuguese = PtPattern();

  /// {@macro ru_pattern}
  static const LanguagePattern russian = RuPattern();

  /// {@macro es_pattern}
  static const LanguagePattern spanish = EsPattern();

  /// {@macro sv_pattern}
  static const LanguagePattern swedish = SvPattern();

  /// {@macro uk_pattern}
  static const LanguagePattern ukrainian = UkPattern();

  /// Combined pattern for all supported languages.
  static const CensorPattern all = CensorPattern.multi(values);

  /// List of all available language patterns.
  static const List<LanguagePattern> values = [
    english,
    finnish,
    french,
    italian,
    german,
    korean,
    kazakh,
    lithuanian,
    latvian,
    polish,
    portuguese,
    russian,
    spanish,
    swedish,
    ukrainian,
    chinese,
  ];
}
