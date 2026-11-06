import 'package:censor_it/censor_it.dart';
import 'package:test/test.dart';

void main() {
  group('MultiCensorPattern', () {
    group('with an empty list', () {
      const pattern = CensorPattern.multi(<CensorPattern>[]);

      test('regExp does not match an empty string', () {
        expect(pattern.regExp.hasMatch(''), isFalse);
      });

      test('regExp does not match arbitrary text', () {
        expect(pattern.regExp.hasMatch('fuck хуй hello'), isFalse);
        expect(pattern.regExp.allMatches('fuck хуй hello'), isEmpty);
      });

      test('reports no profanity', () {
        final censor = CensorIt.mask('fuck хуй hello', pattern: pattern);

        expect(censor.hasProfanity, isFalse);
        expect(censor.swearWords, isEmpty);
        expect(censor.matches, isEmpty);
      });

      test('leaves the text unchanged', () {
        final censor = CensorIt.mask('fuck хуй hello', pattern: pattern);

        expect(censor.censored, equals('fuck хуй hello'));
      });

      test('const empty list behaves the same way', () {
        final censor = CensorIt.mask(
          'fuck',
          pattern: const CensorPattern.multi([]),
        );

        expect(censor.hasProfanity, isFalse);
      });
    });

    group('regExp', () {
      test('detects words from every combined pattern', () {
        const pattern = CensorPattern.multi([
          LanguagePattern.english,
          LanguagePattern.russian,
        ]);
        final censor = CensorIt.mask('fuck и хуй', pattern: pattern);

        expect(censor.swearWords, equals(['fuck', 'хуй']));
      });

      test('ignores languages that were not combined', () {
        const pattern = CensorPattern.multi([
          LanguagePattern.english,
          LanguagePattern.spanish,
        ]);

        expect(CensorIt.mask('хуй', pattern: pattern).hasProfanity, isFalse);
      });

      test('is case-insensitive', () {
        const pattern = CensorPattern.multi([LanguagePattern.english]);

        expect(CensorIt.mask('FUCK', pattern: pattern).hasProfanity, isTrue);
      });

      test('works with custom patterns inside', () {
        final pattern = CensorPattern.multi([
          CensorPattern.fromRegExp(RegExp('badword')),
          LanguagePattern.english,
        ]);
        final censor = CensorIt.mask('badword shit', pattern: pattern);

        expect(censor.swearWords, equals(['badword', 'shit']));
      });
    });

    group('caching', () {
      test('regExp is built once per instance', () {
        const pattern = CensorPattern.multi([
          LanguagePattern.english,
          LanguagePattern.russian,
        ]);

        expect(identical(pattern.regExp, pattern.regExp), isTrue);
      });

      test('LanguagePattern.all builds its regExp once', () {
        expect(
          identical(LanguagePattern.all.regExp, LanguagePattern.all.regExp),
          isTrue,
        );
      });

      test('different instances do not share a cached regExp', () {
        const first = CensorPattern.multi([LanguagePattern.english]);
        const second = CensorPattern.multi([LanguagePattern.russian]);

        expect(first.regExp.hasMatch('fuck'), isTrue);
        expect(second.regExp.hasMatch('fuck'), isFalse);
        expect(identical(first.regExp, second.regExp), isFalse);
      });
    });
  });
}
