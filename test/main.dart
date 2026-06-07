import 'package:censor_it/censor_it.dart';
import 'package:test/test.dart';

import 'censor_it_test.dart';
import 'samples/samples.dart';

void main() {
  group('Pattern Detection Tests', () {
    final patterns = [
      DeSample(),
      EnSample(),
      EsSample(),
      FiSample(),
      ItSample(),
      LvSample(),
      FrSample(),
      KoSample(),
      KkSample(),
      LtSample(),
      PlSample(),
      PtSample(),
      RuSample(),
      SvSample(),
      UkSample(),
      ZhSample(),
    ].map(CensorItTest.new);

    group('Dirty words detection', () {
      for (final pattern in patterns) {
        pattern.dirtyTest();
      }
    });

    group('Safe words validation', () {
      for (final pattern in patterns) {
        pattern.safeTest();
      }
    });
  });

  group('CensorItRandom', () {
    group('Case preservation', () {
      test('preserves uppercase for uppercase words', () {
        const text = 'FUCK';
        final censor = CensorIt.random(
          text,
          pattern: LanguagePattern.english,
        );

        final censored = censor.censored;
        expect(censored, equals(censored.toUpperCase()));
      });

      test('preserves lowercase for lowercase words', () {
        const text = 'FUCK';
        final censor = CensorIt.random(
          text,
          pattern: LanguagePattern.english,
        );

        final censored = censor.censored;
        expect(censored, equals(censored.toLowerCase()));
      });

      test('preserves case in mixed text', () {
        const text = 'This is DICK and fuck';
        final censor = CensorIt.random(
          text,
          pattern: LanguagePattern.english,
        );

        final censored = censor.censored;
        final words = censored.split(' ');

        expect(words[0][0], equals('T'));
        expect(words[2], matches(RegExp(r'^[A-Z!#%&?@\$]+$')));
        expect(words[4], matches(RegExp(r'^[a-z!#%&?@\$]+$')));
      });
    });

    group('Character validation', () {
      test('works with single character', () {
        final censor = CensorIt.random(
          'fuck shit',
          pattern: LanguagePattern.english,
          chars: ['*'],
        );

        expect(censor.censored, equals('**** ****'));
      });

      test('throws error with empty chars list', () {
        expect(
          () => CensorIt.random(
            'shit',
            pattern: LanguagePattern.english,
            chars: [],
          ),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'chars must not be empty',
            ),
          ),
        );
      });

      test('throws error with multi-character string', () {
        expect(
          () => CensorIt.random(
            'shit',
            pattern: LanguagePattern.english,
            chars: ['!', 'ab'],
          ),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Each char must be a single character',
            ),
          ),
        );
      });

      test('works with exactly 2 characters', () {
        final censor = CensorIt.random(
          'fuck',
          pattern: LanguagePattern.english,
          chars: ['!', '#'],
        );

        expect(() => censor.censored, returnsNormally);
        expect(censor.censored.length, equals(4));
      });
    });

    group('Caching behavior', () {
      test('caches censored result', () {
        final censor = CensorIt.random(
          'shit',
          pattern: LanguagePattern.english,
        );
        final firstCall = censor.censored;
        final secondCall = censor.censored;

        expect(firstCall, equals(secondCall));
      });

      test('hashCode remains stable', () {
        final censor = CensorIt.random(
          'test dick',
          pattern: LanguagePattern.english,
        );
        final initialHash = censor.hashCode;
        final initialCensored = censor.censored;

        for (int i = 0; i < 5; i++) {
          expect(censor.censored, equals(initialCensored));
          expect(censor.hashCode, equals(initialHash));
        }
      });
    });

    group('Regeneration', () {
      test('creates new instance', () {
        final original = CensorIt.random(
          'shit',
          pattern: LanguagePattern.english,
        );
        final regenerated = original.regenerate();

        expect(identical(original, regenerated), isFalse);
      });

      test('preserves configuration', () {
        final original = CensorIt.random(
          'shit',
          pattern: LanguagePattern.english,
          chars: ['*', '#'],
        );
        final regenerated = original.regenerate();

        expect(original.original, equals(regenerated.original));
        expect(original.pattern, equals(regenerated.pattern));
      });

      test('generates different censored output', () {
        final original = CensorIt.random(
          'shit',
          pattern: LanguagePattern.english,
        );
        final regenerated = original.regenerate();

        expect(original.censored, isNot(equals(regenerated.censored)));
      });
    });

    group('Long text handling', () {
      test('handles long text with profanity', () {
        final longText = '${'1' * 50}shit${'2' * 50}';
        final censor = CensorIt.random(
          longText,
          pattern: LanguagePattern.english,
        );

        expect(censor.hasProfanity, isTrue);
        expect(censor.swearWords, contains('shit'));
        expect(censor.censored.length, equals(longText.length));
      });
    });
  });

  group('CensorItMask', () {
    test('repeats character by word length', () {
      final censor = CensorIt.mask(
        'fuck',
        pattern: LanguagePattern.english,
      );

      expect(censor.censored, equals('****'));
    });

    test('preserves case with mask character', () {
      final censor = CensorIt.mask(
        'SHIT and fuck',
        pattern: LanguagePattern.english,
      );

      expect(censor.censored, equals('**** and ****'));
    });

    test('throws error with multi-character string', () {
      expect(
        () => CensorIt.mask(
          'shit',
          char: 'ab',
          pattern: LanguagePattern.english,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('CensorItReplace', () {
    test('replaces with fixed string', () {
      final censor = CensorIt.replace(
        'fuck this shit',
        replacement: '[censored]',
        pattern: LanguagePattern.english,
      );

      expect(censor.censored, equals('[censored] this [censored]'));
    });

    test('preserves case of first character', () {
      final censor = CensorIt.replace(
        'FUCK this',
        replacement: 'beep',
        pattern: LanguagePattern.english,
      );

      expect(censor.censored, startsWith('B'));
    });
  });

  group('CensorItBuilder', () {
    test('uses custom builder function', () {
      final censor = CensorIt.builder(
        'fuck shit',
        builder: (word) => '😀',
        pattern: LanguagePattern.english,
      );

      expect(censor.censored, equals('😀 😀'));
    });

    test('builder receives word as parameter', () {
      final censor = CensorIt.builder(
        'fuck shit',
        builder: (word) => '*' * word.length,
        pattern: LanguagePattern.english,
      );

      expect(censor.censored, equals('**** ****'));
    });

    test('builder can use word length logic', () {
      final censor = CensorIt.builder(
        'dick fuck',
        builder: (_) => '🙈',
        pattern: LanguagePattern.english,
      );

      expect(censor.censored, equals('🙈 🙈'));
    });

    test('builder can use word length logic with condition', () {
      final censor = CensorIt.builder(
        'fucking dick',
        builder: (word) => word.length <= 4 ? '🙈' : '🤬',
        pattern: LanguagePattern.english,
      );

      expect(censor.censored, equals('🤬 🙈'));
    });
  });

  group('Pattern handling', () {
    test('CensorPattern.all detects multiple languages', () {
      const text = 'shit хуй kurwa merde';
      final censor = CensorIt.random(
        text,
      );

      expect(censor.hasProfanity, isTrue);
      expect(censor.swearWords.length, greaterThan(1));
    });

    test('custom patterns are independent', () {
      final pattern1 = CensorPattern.fromRegExp(RegExp('first'));
      final pattern2 = CensorPattern.fromRegExp(RegExp('second'));

      final censor1 = CensorIt.random('first word', pattern: pattern1);
      final censor2 = CensorIt.random('second word', pattern: pattern2);

      expect(censor1.swearWords, equals(['first']));
      expect(censor2.swearWords, equals(['second']));
      expect(pattern1.regExp.pattern, equals('first'));
      expect(pattern2.regExp.pattern, equals('second'));
    });
  });

  group('Edge cases', () {
    test('handles empty text', () {
      final censor = CensorIt.random(
        '',
        pattern: LanguagePattern.english,
      );

      expect(censor.censored, equals(''));
      expect(censor.hasProfanity, isFalse);
      expect(censor.swearWords, isEmpty);
      expect(censor.original, equals(''));
    });

    test('handles text without profanity', () {
      final censor = CensorIt.random(
        'Hello world',
        pattern: LanguagePattern.english,
      );

      expect(censor.hasProfanity, isFalse);
      expect(censor.swearWords, isEmpty);
      expect(censor.censored, equals('Hello world'));
    });
  });

  group('Equality', () {
    test('equal instances have same original and pattern', () {
      final censor1 = CensorIt.random(
        'fuck',
        pattern: LanguagePattern.english,
      );
      final censor2 = CensorIt.random(
        'fuck',
        pattern: LanguagePattern.english,
      );

      expect(censor1.original, equals(censor2.original));
      expect(censor1.pattern, equals(censor2.pattern));
    });

    test('different patterns create unequal instances', () {
      final censor1 = CensorIt.random(
        'fuck',
        pattern: LanguagePattern.english,
      );
      final censor2 = CensorIt.random(
        'fuck',
        pattern: LanguagePattern.russian,
      );

      expect(censor1.pattern, isNot(equals(censor2.pattern)));
    });
  });
}
