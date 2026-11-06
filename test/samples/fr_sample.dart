import 'package:censor_it/src/patterns/language_pattern.dart';

import 'base_sample.dart';

class FrSample implements BaseSample {
  @override
  LanguagePattern get pattern => LanguagePattern.french;

  @override
  List<String> get badWords => [
        'putain',
        'putains',
        'pute',
        'putes',
        'nique',
        'niqué',
        'niquer',
        'niquez',
        'fils de pute',
        'enculé',
        'enculer',
        'connard',
        'connards',
        'connasse',
        'salope',
        'salopes',
        'bâtard',
        'batard',
      ];

  @override
  List<String> get safeWords => [
        'réputation', // …puta…
        'technique', // …nique…
        'abatardir', // …batard…
        'salopette', // …salope…
      ];
}
