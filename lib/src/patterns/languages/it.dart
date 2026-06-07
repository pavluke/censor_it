part of '../language_pattern.dart';

/// {@template it_pattern}
/// Italian profanity pattern.
///  {@endtemplate}
final class ItPattern implements LanguagePattern {
  /// {@macro it_pattern}
  const ItPattern();

  @override
  String get name => 'italian';

  @override
  String get locale => 'it';

  @override
  RegExp get regExp => RegExp(
        '(?<![a-zàèéìòù])'
        '(?:'
        'vaffanculo' // vaffanculo
        '|cazz[a-zàèéìòù]*' // cazzo, cazzata, cazzoni ...
        '|coglion[a-zàèéìòù]*' // coglione, coglioni ...
        '|stronz[a-zàèéìòù]*' // stronzo, stronzi ...
        '|troi[a-zàèéìòù]*' // troia, troie ...
        '|puttan[a-zàèéìòù]*' // puttana, puttane ...
        '|merd[a-zàèéìòù]*' // merda, merdoso ...
        ')'
        '(?![a-zàèéìòù])',
        caseSensitive: false,
      );
}
