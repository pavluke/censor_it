import 'package:censor_it/src/patterns/language_pattern.dart';

import 'base_sample.dart';

class LvSample implements BaseSample {
  @override
  LanguagePattern get pattern => LanguagePattern.latvian;

  @override
  List<String> get badWords => [
        'pist',
        'pisies',
        'pisu',
        'pisās',
        'pizda',
        'pizdets',
        'pizdām',
        'dirsa',
        'dirsā',
        'dirš',
        'pimpis',
        'pimpi',
        'pimpja',
        'mauka',
        'maukas',
        'maukām',
      ];

  @override
  List<String> get safeWords => [
        'kepistācija', // …pis…
        'endirsēts', // …dirs…
        'maukalons', // …mauk…
        'pistole', // …pis…
        'pistolets', // …pis…
        'pistācijas', // …pis…
        'Pisa', // город
      ];
}
