// ignore_for_file: avoid_log

import 'dart:developer';

import 'package:censor_it/censor_it.dart';

const String _text = '''
Это ебаный текст для блядской проверки!
I don't give a fuck that there are a lot of obscene words here!
I'm sure the developer of this lib is an asshole!''';

void main() {
  final examples = <(String, void Function())>[
    ('Basic English censoring with masking', _basicMask),
    ('All languages pattern', _allLanguages),
    ('Random character replacement', _randomChars),
    ('Simple masking with single character', _simpleMask),
    ('Fixed string replacement', _fixedReplace),
    ('Custom builder function', _customBuilder),
    ('Using .censor() extension', _extension),
    ('Regenerating random censored text', _regenerate),
    ('Custom RegExp pattern', _customPattern),
    ('Multi-language censoring', _multiLanguage),
    ('Using GetMatchesX extension', _matches),
  ];

  for (final (index, (title, run)) in examples.indexed) {
    _log('${index + 1}. $title');
    run();
    _log('');
  }
}

void _basicMask() {
  final censor = CensorIt.mask(_text, pattern: LanguagePattern.english);

  _result(censor.censored);
  _result('Has profanity: ${censor.hasProfanity}');
  _result('Swear words: ${censor.swearWords}');
}

void _allLanguages() {
  final censor = CensorIt.mask(_text);

  _result(censor.censored);
  _result('Total swear words: ${censor.swearWords.length}');
}

void _randomChars() {
  final censor = CensorIt.random(
    'This is fucking shit!',
    pattern: LanguagePattern.english,
    chars: ['*', '#', '@'],
  );

  _result(censor.censored);
}

void _simpleMask() {
  final censor = CensorIt.mask('fuck', pattern: LanguagePattern.english);

  _result(censor.censored);
}

void _fixedReplace() {
  final censor = CensorIt.replace(
    'fuck this shit',
    replacement: '[censored]',
    pattern: LanguagePattern.english,
  );

  _result(censor.censored);
}

void _customBuilder() {
  final censor = CensorIt.builder(
    'fucking shit bastard',
    builder: (word) => word.length <= 4 ? '💩' : '🤬',
    pattern: LanguagePattern.english,
  );

  _result(censor.censored);
}

void _extension() {
  _result('fuck this shit'.censor(pattern: LanguagePattern.english));
}

void _regenerate() {
  final first = CensorIt.random('shit', pattern: LanguagePattern.english);
  final second = first.regenerate();
  final third = second.regenerate();

  _result('First:  ${first.censored}');
  _result('Second: ${second.censored}');
  _result('Third:  ${third.censored}');
}

void _customPattern() {
  final censor = CensorIt.mask(
    'badword and anotherbad in text',
    pattern: CensorPattern.fromRegExp(RegExp('badword|anotherbad')),
  );

  _result(censor.censored);
  _result('Custom words found: ${censor.swearWords}');
}

void _multiLanguage() {
  final censor = CensorIt.random(
    'fuck you puta',
    pattern: LanguagePattern.fromLocales(['en', 'es', 'ru']),
  );

  _result(censor.censored);
  _result('Words detected: ${censor.swearWords}');
}

void _matches() {
  final censor = CensorIt.random(
    'fuck this shit bastard',
    pattern: LanguagePattern.english,
  );

  _result('Total matches: ${censor.matches.length}');
  for (final match in censor.matches) {
    _result('Found "${match.group(0)}" at index ${match.start}');
  }
}

void _log(String message) => log(message, name: 'censor_it');

void _result(Object? value) => _log('   → $value');
