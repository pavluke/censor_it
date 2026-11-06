import 'package:censor_it/src/patterns/language_pattern.dart';

import 'base_sample.dart';

class FiSample implements BaseSample {
  @override
  LanguagePattern get pattern => LanguagePattern.finnish;

  @override
  List<String> get badWords => [
        'vittu',
        'vitun',
        'vittua',
        'vittuun',
        'kyrpä',
        'kyrpää',
        'kyrvän',
        'pillu',
        'pillut',
        'huora',
        'huorat',
      ];

  @override
  List<String> get safeWords => [
        'avitamiini', // …vit…
        'kapillaarinen', // …pill…
        'ankyrin', // …kyr…
        'vitamiini', // …vit…
        'vitsi', // …vit…
        'vitriini', // …vit…
      ];
}
