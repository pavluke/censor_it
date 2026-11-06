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

  static final RegExp _regExp = RegExp(
        '(?<![a-zàèéìòù])'
        '(?:'
        'vaffanculo' // vaffanculo
        '|cazz(?!uol)[a-zàèéìòù]*' // cazzo, cazzata, cazzoni ...
        '|coglion[a-zàèéìòù]*' // coglione, coglioni ...
        '|stronz(?!io)[a-zàèéìòù]*' // stronzo, stronzi ...
        '|troi[a-zàèéìòù]*' // troia, troie ...
        '|puttan[a-zàèéìòù]*' // puttana, puttane ...
        '|merd[a-zàèéìòù]*' // merda, merdoso ...
        ')'
        '(?![a-zàèéìòù])',
        caseSensitive: false,
      );

  @override
  RegExp get regExp => _regExp;
}
