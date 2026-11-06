import 'package:censor_it/censor_it.dart';
import 'package:test/test.dart';

void main() {
  group('GetMatchesX', () {
    group('matches', () {
      test('returns every match with correct offsets', () {
        final censor = CensorIt.mask(
          'fuck this shit',
          pattern: LanguagePattern.english,
        );

        final ranges = censor.matches.map((m) => (m.start, m.end)).toList();

        expect(ranges, equals([(0, 4), (10, 14)]));
      });

      test('is empty when there is no profanity', () {
        final censor = CensorIt.mask(
          'Hello world',
          pattern: LanguagePattern.english,
        );

        expect(censor.matches, isEmpty);
      });

      test('is case-insensitive', () {
        final censor = CensorIt.mask(
          'FUCK',
          pattern: LanguagePattern.english,
        );

        expect(censor.matches, hasLength(1));
        expect(censor.matches.single.start, equals(0));
        expect(censor.matches.single.end, equals(4));
      });

      test('works for every CensorIt implementation', () {
        const text = 'fuck this';
        const pattern = LanguagePattern.english;
        final censors = <CensorIt>[
          CensorIt.mask(text, pattern: pattern),
          CensorIt.random(text, pattern: pattern),
          CensorIt.replace(text, replacement: '[x]', pattern: pattern),
          CensorIt.builder(text, builder: (_) => '[x]', pattern: pattern),
        ];

        for (final censor in censors) {
          expect(censor.matches, hasLength(1), reason: '$censor');
        }
      });
    });

    group('caching', () {
      test('matches are computed once per instance', () {
        final censor = CensorIt.mask(
          'fuck this shit',
          pattern: LanguagePattern.english,
        );

        expect(identical(censor.matches, censor.matches), isTrue);
      });

      test('returned list is unmodifiable', () {
        final censor = CensorIt.mask(
          'fuck this',
          pattern: LanguagePattern.english,
        );

        expect(() => censor.matches.clear(), throwsUnsupportedError);
      });

      test('instances do not share cached matches', () {
        final first = CensorIt.mask('fuck', pattern: LanguagePattern.english);
        final second = CensorIt.mask('shit', pattern: LanguagePattern.english);

        expect(first.matches.single.group(0), equals('fuck'));
        expect(second.matches.single.group(0), equals('shit'));
      });

      test('regenerate() produces an instance with its own matches', () {
        final original = CensorIt.random(
          'fuck shit',
          pattern: LanguagePattern.english,
        );
        final regenerated = original.regenerate();

        expect(original.matches, hasLength(2));
        expect(regenerated.matches, hasLength(2));
        expect(identical(original.matches, regenerated.matches), isFalse);
      });
    });

    group('consistency with CensorIt', () {
      test('hasProfanity agrees with matches', () {
        const pattern = LanguagePattern.english;

        expect(CensorIt.mask('fuck', pattern: pattern).hasProfanity, isTrue);
        expect(CensorIt.mask('hello', pattern: pattern).hasProfanity, isFalse);
      });

      test('swearWords are the matched words in order, lowercased', () {
        final censor = CensorIt.mask(
          'Fuck this SHIT',
          pattern: LanguagePattern.english,
        );

        expect(censor.swearWords, equals(['fuck', 'shit']));
      });

      test('swearWords is a fresh list each time', () {
        final censor = CensorIt.mask(
          'fuck this',
          pattern: LanguagePattern.english,
        );

        censor.swearWords.add('extra');

        expect(censor.swearWords, equals(['fuck']));
      });
    });
  });
}
