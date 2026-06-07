// ignore_for_file: avoid_log

import 'dart:developer';

import 'package:censor_it/censor_it.dart';

void _log(String msg) => log(msg, name: 'censor_it');

void main() {
  const String text = '''
Это ебаный текст для блядской проверки!
I don't give a fuck that there are a lot of obscene words here!
I'm sure the developer of this lib is an asshole!''';

  _log('1. Basic English censoring with masking:');
  final basicCensor = CensorIt.mask(text, pattern: LanguagePattern.english);
  _log(basicCensor.censored);
  _log('Has profanity: ${basicCensor.hasProfanity}');
  _log('Swear words: ${basicCensor.swearWords}\n');

  _log('2. All languages pattern:');
  final allLanguages = CensorIt.mask(text);
  _log(allLanguages.censored);
  _log('Total swear words: ${allLanguages.swearWords.length}\n');

  _log('3. Random character replacement:');
  final customChars = CensorIt.random(
    'This is fucking shit!',
    pattern: LanguagePattern.english,
    chars: ['*', '#', '@'],
  );
  _log(customChars.censored);
  _log('');

  _log('4. Simple masking with single character:');
  final simpleMask = CensorIt.mask('fuck', pattern: LanguagePattern.english);
  _log(simpleMask.censored);
  _log('');

  _log('5. Fixed string replacement:');
  final fixedReplace = CensorIt.replace(
    'fuck this shit',
    replacement: '[censored]',
    pattern: LanguagePattern.english,
  );
  _log(fixedReplace.censored);
  _log('');

  _log('6. Custom builder function:');
  final customBuilder = CensorIt.builder(
    'fucking shit bastard',
    builder: (word) => word.length <= 4 ? '💩' : '🤬',
    pattern: LanguagePattern.english,
  );
  _log(customBuilder.censored);
  _log('');

  _log('7. Using .censored() extension:');
  _log('fuck this shit'.censored(pattern: LanguagePattern.english));
  _log('');

  _log('8. Regenerating random censored text:');
  final original = CensorIt.random('shit', pattern: LanguagePattern.english);
  _log('First:  ${original.censored}');
  final regenerated = original.regenerate();
  _log('Second: ${regenerated.censored}');
  final thirdGen = regenerated.regenerate();
  _log('Third:  ${thirdGen.censored}\n');

  _log('9. Custom RegExp pattern:');
  final customPattern = CensorIt.mask(
    'badword and anotherbad in text',
    pattern: CensorPattern.fromRegExp(RegExp('badword|anotherbad')),
  );
  _log(customPattern.censored);
  _log('Custom words found: ${customPattern.swearWords}\n');

  _log('10. Multi-language censoring:');
  final multiLang = CensorIt.random(
    'fuck you puta',
    pattern: LanguagePattern.fromLocales(['en', 'es', 'ru']),
  );
  _log(multiLang.censored);
  _log('Languages detected: ${multiLang.swearWords}\n');

  _log('11. Using GetMatchesX extension:');
  final matchesExample = CensorIt.random(
    'fuck this shit bastard',
    pattern: LanguagePattern.english,
  );
  _log('Total matches: ${matchesExample.matches.length}');
  for (final match in matchesExample.matches) {
    _log('  - Found "${match.group(0)}" at index ${match.start}');
  }
}
