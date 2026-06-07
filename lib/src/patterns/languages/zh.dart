part of '../language_pattern.dart';

/// {@template zh_pattern}
/// Chinese profanity pattern.
///  {@endtemplate}
final class ZhPattern implements LanguagePattern {
  /// {@macro zh_pattern}
  const ZhPattern();

  @override
  String get name => 'chinese';

  @override
  String get locale => 'zh';

  @override
  RegExp get regExp => RegExp(
        '(?:'
        '操你祖宗十八代|'
        '[操肏艹](?:你|妳|您)?祖宗|'
        '臭婊子|'
        '[操肏艹](?:你|妳|您)?(?:妈|媽)(?:的)?(?:[屄逼])?|'
        '你?[妈媽][屄逼]|'
        '去你[妈媽]的|滚你[妈媽]|'
        '日你(?:[妈媽])?|日死你|'
        '我操|卧槽|操你|操蛋|'
        '鸡巴|雞巴|鷄巴|屌丝|婊子|贱货|'
        '[傻二煞装裝牛][屄逼]|'
        r'(?<![一-龯\u3400-\u4DBF])逼(?![一-龯\u3400-\u4DBF真迫])|'
        r'(?<![一-龯\u3400-\u4DBF])操(?![一-龯\u3400-\u4DBF作场练心纵])|'
        r'(?<![一-龯\u3400-\u4DBF])干(?![一-龯\u3400-\u4DBF净燥杯活部脆扰])|'
        r'(?<![一-龯\u3400-\u4DBF])幹(?![一-龯\u3400-\u4DBF])|'
        r'(?<![一-龯\u3400-\u4DBF])日(?![一-龯\u3400-\u4DBF本期常子历光])|'
        r'(?<![一-龯\u3400-\u4DBF])屌(?![一-龯\u3400-\u4DBF])|'
        '屄|肏|艹'
        ')',
        caseSensitive: false,
        unicode: true,
      );
}
