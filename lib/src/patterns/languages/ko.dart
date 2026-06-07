part of '../language_pattern.dart';

/// {@template ko_pattern}
/// Korean profanity pattern.
/// {@endtemplate}
final class KoPattern implements LanguagePattern {
  /// {@macro ko_pattern}
  const KoPattern();

  @override
  String get name => 'korean';

  @override
  String get locale => 'ko';

  @override
  RegExp get regExp => RegExp(
        '(?:'
        '[씨시쓔쉬쒸슈][발벌팔펄빨뻘]|'
        'ㅅㅣㅂㅏㄹ|'
        '개[새쌔섀쉐][끼꺼기]|'
        '개[새쌔]?[키퀴]|'
        '[좆좇졷좄좃좉졽](?:까|가|됐어|됐다|돼|되)|'
        '[존좉][나니]|'
        '[좆좇졷좄좃좉졽]|'
        '(?<![가-힣])보[지찌](?![가-힣])|'
        '[봊봋봇봈볻봁봍][빨이]|'
        '[병븅][신쉰]|'
        '지[랄럴뢀]|'
        '창[녀놈]|'
        '[씹쒸][팔빨창할]|'
        '씹세|씹새|'
        '미친[놈년새]|'
        r'엿\s*먹어|'
        '니[애에]미|'
        r'걸레\s*년|'
        r'화냥\s*년|'
        '꼬추|'
        '[후훚훐][장앙]|'
        '[색섹][끼키]|'
        '조[선센][징]|조센'
        ')',
        caseSensitive: false,
        unicode: true,
      );
}
