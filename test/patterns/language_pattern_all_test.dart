import 'package:censor_it/censor_it.dart';
import 'package:test/test.dart';

/// `LanguagePattern.all` is the default pattern, so a greedy regex in any
/// single language also affects text written in every other language.
void main() {
  group('LanguagePattern.all', () {
    group('does not flag ordinary words', () {
      const benignWords = [
        // English words that start like Portuguese "cu"
        'customer', 'cute', 'cut', 'cup', 'culture', 'curious', 'cucumber',
        // ...like Swedish "hor"
        'horizon', 'hormone', 'horn', 'horoscope',
        // ...like Finnish "vit"
        'vitamin', 'vital', 'vitality',
        // ...like Latvian "pis"
        'pistol', 'piston', 'Pisa', 'pistachio',
        // Russian "с" + "еб"
        'себя', 'себе', 'себестоимость', 'себорея',
        // Russian prefixes before "ъ"
        'съезд', 'подъезд', 'объезд',
        // Italian, French
        'cazzuola', 'stronzio', 'salopette',
      ];

      for (final word in benignWords) {
        test('"$word"', () {
          final censor = CensorIt.mask(word);

          expect(
            censor.hasProfanity,
            isFalse,
            reason: 'Detected: ${censor.swearWords}',
          );
        });
      }

      test('in a full sentence', () {
        final censor = CensorIt.mask(
          'The customer bought a cute pistol and a vitamin at the horizon.',
        );

        expect(censor.hasProfanity, isFalse);
        expect(
          censor.censored,
          equals(
            'The customer bought a cute pistol and a vitamin at the horizon.',
          ),
        );
      });

      test('in a Russian sentence', () {
        final censor = CensorIt.mask('Он купил себе хлеб и вернулся к себе.');

        expect(censor.hasProfanity, isFalse);
      });
    });

    group('still flags profanity', () {
      const profaneWords = {
        'en': 'fuck',
        'ru': 'хуй',
        'ru (prefix)': 'выебал',
        'ru (съ-)': 'съебаться',
        'pl': 'kurwa',
        'fi': 'vittu',
        'fi (form)': 'vitun',
        'sv': 'hora',
        'sv (form)': 'horungar',
        'lv': 'pist',
        'it': 'cazzo',
        'fr': 'salope',
        'pt': 'cuzão',
      };

      profaneWords.forEach((language, word) {
        test('$language: "$word"', () {
          expect(CensorIt.mask(word).hasProfanity, isTrue);
        });
      });
    });
  });
}
