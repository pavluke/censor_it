import 'package:censor_it/censor_it.dart';
import 'package:test/test.dart';

void main() {
  group('CensoredX', () {
    group('censor()', () {
      test('replaces profanity and keeps the rest of the text', () {
        const text = 'fuck this';
        final result = text.censor(pattern: LanguagePattern.english);

        expect(result, endsWith(' this'));
        expect(result.toLowerCase(), isNot(contains('fuck')));
        expect(result.length, equals(text.length));
      });

      test('leaves text without profanity unchanged', () {
        expect(
          'Hello world'.censor(pattern: LanguagePattern.english),
          equals('Hello world'),
        );
      });

      test('uses all languages by default', () {
        final result = 'fuck и хуй'.censor();

        expect(CensorIt.mask(result).hasProfanity, isFalse);
        expect(result.toLowerCase(), isNot(contains('fuck')));
        expect(result.toLowerCase(), isNot(contains('хуй')));
      });

      test('replaces with random characters, not letters', () {
        final result = 'shit'.censor(pattern: LanguagePattern.english);

        expect(result, matches(RegExp(r'^[!#%&?@$]{4}$')));
      });
    });

    group('censored()', () {
      test('still censors the text', () {
        final result = 'fuck this'.censor(pattern: LanguagePattern.english);

        expect(result, endsWith(' this'));
        expect(result.toLowerCase(), isNot(contains('fuck')));
      });
    });
  });
}
