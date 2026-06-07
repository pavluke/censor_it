import 'custom_pattern.dart';
import 'multi_censor_pattern.dart';

/// Abstract interface for censor patterns.
///
/// Provides a regular expression for detecting profanity.
/// Use predefined patterns from [LanguagePattern] or create custom ones.
///
/// Example:
/// ```
/// final pattern = LanguagePattern.english;
/// final custom = CensorPattern.fromRegExp(RegExp(r'\b(fuck|shit)\b'));
/// final combined = CensorPattern.multi([
///   LanguagePattern.english,
///   LanguagePattern.russian,
/// ]);
/// ```
abstract interface class CensorPattern {
  /// {@macro custom_pattern_constructor}
  const factory CensorPattern.fromRegExp(RegExp regExp) = CustomPattern;

  /// {@macro multi_censor_pattern_constructor}
  const factory CensorPattern.multi(List<CensorPattern> patterns) =
      MultiCensorPattern;

  /// {@template censor_pattern_regexp_getter}
  /// Returns a regular expression for profanity detection.
  /// {@endtemplate}
  RegExp get regExp;
}
