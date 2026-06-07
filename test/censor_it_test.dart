import 'package:censor_it/censor_it.dart';
import 'package:test/test.dart';

import 'samples/base_sample.dart';

typedef Samples = ({List<String> dirty, List<String> safe});

class CensorItTest {
  CensorItTest(this.sample);
  final BaseSample sample;

  void dirtyTest() {
    test('Detect ${sample.pattern.name} swear words', () {
      final String textWithSwearWords = sample.badWords.toSet().join(' ');

      final CensorIt censorIt = CensorIt.mask(
        textWithSwearWords,
        pattern: sample.pattern,
      );

      final List<String> detectedSwearWords = censorIt.swearWords;

      for (final String badWords in sample.badWords) {
        expect(detectedSwearWords, contains(badWords));
      }
    });
  }

  void safeTest() {
    test('Ignore benign ${sample.pattern.name} look-alikes', () {
      final String benignText = sample.safeWords.toSet().join(' ');
      final CensorIt censorIt = CensorIt.mask(
        benignText,
        pattern: sample.pattern,
      );

      expect(
        censorIt.swearWords,
        isEmpty,
        reason: 'Detected swear words where there should be none.',
      );

      for (final word in sample.safeWords) {
        expect(
          censorIt.swearWords,
          isNot(contains(word)),
          reason: 'False positive detected for "$word".',
        );
      }
    });
  }
}
