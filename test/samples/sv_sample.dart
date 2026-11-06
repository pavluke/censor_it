import 'package:censor_it/src/patterns/language_pattern.dart';

import 'base_sample.dart';

class SvSample implements BaseSample {
  @override
  LanguagePattern get pattern => LanguagePattern.swedish;

  @override
  List<String> get badWords => [
        'fitta',
        'fittan',
        'fittor',
        'fittigt',
        'kuk',
        'kuken',
        'kukar',
        'knull',
        'knulla',
        'knullar',
        'knullade',
        'knullat',
        'hora',
        'horan',
        'horor',
        'horunge',
        'horungar',
      ];

  @override
  List<String> get safeWords => [
        'benefitting', // …fitt…
        'kukurbit', // …kuk…
        'honor', // …hor…
        'horisont', // …hor…
        'hormon', // …hor…
        'horn', // …hor…
        'horoskop', // …hor…
      ];
}
