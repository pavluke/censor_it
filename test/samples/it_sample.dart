import 'package:censor_it/src/patterns/language_pattern.dart';

import 'base_sample.dart';

class ItSample implements BaseSample {
  @override
  LanguagePattern get pattern => LanguagePattern.italian;

  @override
  List<String> get badWords => [
        'cazzo',
        'cazzi',
        'cazzata',
        'cazzate',
        'cazzoni',
        'coglione',
        'coglioni',
        'stronzo',
        'stronzi',
        'troia',
        'troie',
        'puttana',
        'puttane',
        'vaffanculo',
        'merda',
        'merde',
        'merdoso',
      ];

  @override
  List<String> get safeWords => [
        'reputazione', // …puta…
        'Picazzo', // …cazzo…
        'astronomico', // …stron…
        'cazzuola', // …cazz…
        'stronzio', // …stronz…
      ];
}
