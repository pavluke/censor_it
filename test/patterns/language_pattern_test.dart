import 'package:censor_it/censor_it.dart';
import 'package:test/test.dart';

void main() {
  group('LanguagePattern', () {
    group('regExp caching', () {
      for (final pattern in LanguagePattern.values) {
        test('${pattern.name} returns the same RegExp instance', () {
          expect(identical(pattern.regExp, pattern.regExp), isTrue);
        });
      }
    });

    group('fromLocales', () {
      test('single locale returns the language pattern itself', () {
        expect(
          LanguagePattern.fromLocales(['ru']),
          same(LanguagePattern.russian),
        );
      });

      test('returns the same combined pattern for the same locales', () {
        final first = LanguagePattern.fromLocales(['en', 'es']);
        final second = LanguagePattern.fromLocales(['en', 'es']);

        expect(first, same(second));
      });

      test('combined regExp is not rebuilt between calls', () {
        final first = LanguagePattern.fromLocales(['en', 'es']).regExp;
        final second = LanguagePattern.fromLocales(['en', 'es']).regExp;

        expect(first, same(second));
      });

      test('different locale sets give different patterns', () {
        final enEs = LanguagePattern.fromLocales(['en', 'es']);
        final enRu = LanguagePattern.fromLocales(['en', 'ru']);

        expect(enEs, isNot(same(enRu)));
      });

      test('duplicate locales do not duplicate patterns', () {
        final pattern = LanguagePattern.fromLocales(['en', 'en']);

        expect(pattern, same(LanguagePattern.english));
      });

      test('detects words from every requested language', () {
        final censor = CensorIt.mask(
          'fuck you puta',
          pattern: LanguagePattern.fromLocales(['en', 'es']),
        );

        expect(censor.swearWords, containsAll(['fuck', 'puta']));
      });

      test('does not detect languages that were not requested', () {
        final censor = CensorIt.mask(
          'хуй',
          pattern: LanguagePattern.fromLocales(['en', 'es']),
        );

        expect(censor.hasProfanity, isFalse);
      });

      test('empty locales combine all languages and are memoized', () {
        final first = LanguagePattern.fromLocales([]);
        final second = LanguagePattern.fromLocales([]);

        expect(first, same(second));
        expect(CensorIt.mask('fuck', pattern: first).hasProfanity, isTrue);
        expect(CensorIt.mask('хуй', pattern: first).hasProfanity, isTrue);
      });
    });
  });
}
