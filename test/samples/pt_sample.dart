import 'package:censor_it/src/patterns/language_pattern.dart';

import 'base_sample.dart';

class PtSample implements BaseSample {
  @override
  LanguagePattern get pattern => LanguagePattern.portuguese;

  @override
  List<String> get badWords => [
        'caralho',
        'caralhos',
        'foda',
        'foda-se',
        'foder',
        'fodido',
        'fodeu',
        'porra',
        'puta',
        'putas',
        'filho da puta',
        'filhos da puta',
        'merda',
        'merdas',
        'cu',
        'cuzão',
        'cuzona',
      ];

  @override
  List<String> get safeWords => [
        'computador', // …puta…
        'envergadura', // …verga…
        'profoderação', // …fod…
        'cultura', // …cu…
        'curso', // …cu…
        'cuidado', // …cu…
        'cubo', // …cu…
        'curioso', // …cu…
      ];
}
