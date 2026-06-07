<p align="center">
  <img src="https://github.com/Pavluke/censor_it/blob/main/images/banner.png?raw=true" alt="Banner" />
</p>

[![Pub](https://img.shields.io/pub/v/censor_it.svg)](https://pub.dartlang.org/packages/censor_it)

[En](README.md) | **Ru**

Dart библиотека для цензурирования текста на основе предопределенных паттернов и
настраиваемых символов.

## Руководство по миграции

Обновляетесь с v1.x? Смотрите подробное [Руководство по миграции](MIGRATION.md)
с пошаговыми инструкциями.

## 🚀 Интеграция с Flutter:

Для Flutter приложений используйте пакет `censor_it_flutter`
[GitHub](https://github.com/pavluke/censor_it_flutter) |
[Pub.dev](https://pub.dev/packages/censor_it_flutter)

## Введение

Когда дело доходит до цензурирования текста в вашем Dart приложении, вам может
понадобиться обработка нескольких языков и настройка символов, используемых для
цензуры. `CensorIt` предоставляет простое в использовании решение с несколькими
стратегиями цензурирования.

## Поддерживаемые языки

- 🇺🇸 Английский (EN)
- 🇪🇸 Испанский (ES)
- 🇮🇹 Итальянский (IT)
- 🇰🇿 Казахский (KK)
- 🇨🇳 Китайский (ZH)
- 🇩🇪 Немецкий (DE)
- 🇱🇻 Латышский (LV)
- 🇱🇹 Литовский (LT)
- 🇰🇷 Корейский (KO)
- 🇵🇹 Португальский (PT)
- 🇵🇱 Польский (PL)
- 🇷🇺 Русский (RU)
- 🇺🇦 Украинский (UK)
- 🇫🇮 Финский (FI)
- 🇫🇷 Французский (FR)
- 🇸🇪 Шведский (SV)

## Начало работы

Добавьте censor_it в ваш `pubspec.yaml`:

```yaml
dependencies:
  censor_it: ^2.1.2
```

Или используя команду:

```bash
dart pub add censor_it
```

Импортируйте пакет в ваш Dart файл:

```dart
import 'package:censor_it/censor_it.dart';
```

## Использование

### Базовый пример

```dart
void main() {
  const String text = '''
I don't give a fuck that there are a lot of obscene words here!
I'm sure the developer of this lib is an asshole!''';

  // Создайте экземпляр с маскированием
  final censoredText = CensorIt.mask(text, pattern: LanguagePattern.all);

  // Получите отцензурированный текст
  print(censoredText.censored);
  // Вывод: I don't give a **** that there are a lot of obscene words here!
  // I'm sure the developer of this lib is an *******!

  // Проверьте, содержит ли текст мат
  print(censoredText.hasProfanity); // Вывод: true

  // Получите список найденных матерных слов
  print(censoredText.swearWords); // Вывод: [fuck, asshole]
}
```

## Фабричные конструкторы (v2.0.0+)

CensorIt v2.0.0 вводит четыре фабричных конструктора для различных стратегий
цензурирования:

### 1. CensorIt.random() - Замена случайными символами

Заменяет мат случайными символами из настраиваемого набора.

```dart
final random = CensorIt.random(
  'это пиздец',
  pattern: LanguagePattern.russian,
  chars: ['!', '#', '%', '&', '?', '@', r'\$'],
);
print(random.censored); // это !@#$%#
```

**Применение:** Динамическая, разнообразная цензура, которая выглядит по-разному
каждый раз.

### 2. CensorIt.mask() - Простая маскировка символами

Заменяет мат повторением одного символа.

```dart
final masked = CensorIt.mask(
  'это пиздец',
  char: '*',
  pattern: LanguagePattern.russian,
);
print(masked.censored); // это ******
```

**Применение:** Чистая, последовательная маскировка без случайности.

### 3. CensorIt.builder() - Пользовательская логика замены

Предоставляет полный контроль над заменой с помощью функции-строителя.

```dart
// Замена длиной слова
final lengthBased = CensorIt.builder(
  'Это пиздец',
  builder: (word) => '[${word.length}]',
  pattern: LanguagePattern.russian,
);
print(lengthBased.censored); // Это [6]

// Условная замена
final conditional = CensorIt.builder(
  'Это блять пиздец',
  builder: (word) => word.length > 5 ? '****' : '***',
  pattern: LanguagePattern.russian,
);
print(conditional.censored); // Это *** ****
```

**Применение:** Сложная логика, аналитика или потребности в пользовательском
форматировании.

### 4. CensorIt.replace() - Замена фиксированной строкой

Заменяет весь мат одной и той же фиксированной строкой.

```dart
final fixed = CensorIt.replace(
  'Это пиздец',
  replacement: '[цензура]',
  pattern: LanguagePattern.russian,
);
print(fixed.censored); // Это [цензура]

// Сохранение регистра
final preserved = CensorIt.replace(
  'Это пиздец',
  replacement: 'БИП',
  pattern: LanguagePattern.russian,
);
print(preserved.censored); // Это БИП
```

**Применение:** Последовательная, читаемая замена для всего мата.

## Языковые паттерны

### Использование предопределенных паттернов

```dart
// Один язык
final english = CensorIt.mask('fuck this', pattern: LanguagePattern.english);
final russian = CensorIt.mask('это пиздец', pattern: LanguagePattern.russian);

// Все языки сразу
final allLangs = CensorIt.mask('fuck this, блять', pattern: LanguagePattern.all);
```

### Комбинирование нескольких языков

```dart
// Объединить конкретные языки
final multiLang = CensorIt.mask(
  'fuck this puta',
  pattern: CensorPattern.multi([
    LanguagePattern.english,
    LanguagePattern.spanish,
    LanguagePattern.russian,
  ]),
);
```

### Выбор паттерна по локали (v2.0.0+)

```dart
// Получить паттерн по коду локали
final latvian = LanguagePattern.fromLocale('lv');
final censor = CensorIt.mask('pizdets', pattern: latvian);

// С резервным вариантом
final pattern = LanguagePattern.fromLocale(
  'unknown',
  fallback: LanguagePattern.russian,
);

// Несколько локалей
final multi = LanguagePattern.fromLocales(['en', 'es']);
final censor = CensorIt.mask('fuck this puta', pattern: multi);
```

### Пользовательские паттерны

```dart
// Создать пользовательский паттерн с RegExp
final customPattern = CensorPattern.fromRegExp(
  RegExp(r'плохоеслово|другоеплохое', caseSensitive: false),
);
final censor = CensorIt.mask('плохоеслово здесь', pattern: customPattern);
```

## Использование расширений String

```dart
final text = 'ебать этот пиздец';

// Получить отцензурированную строку напрямую
print(text.censored(pattern: LanguagePattern.russian));
// Вывод: ***** этот ******
```

## Перегенерация отцензурированного текста (только для CensorIt.random)

```dart
final censor1 = CensorIt.random('пиздец', pattern: LanguagePattern.russian);
print(censor1.censored); // @#%!&

// Создать новый экземпляр с другой случайной цензурой
final censor2 = censor1.regenerate();
print(censor2.censored); // %&!#@ (другой)
print(censor1.censored); // @#%!& (оригинал не изменен)
```

**Примечание:** `regenerate()` доступен только для экземпляров
`CensorIt.random()`.

## Возможности

- **Множественные стратегии цензурирования**: Выбирайте из random, mask, builder
  или replace
- **Фабричные конструкторы**: Чистый API с `CensorIt.random()`,
  `CensorIt.mask()` и т.д.
- **Настраиваемые паттерны**: Используйте предопределенные паттерны или
  создавайте свои с помощью `CensorPattern.fromRegExp()`
- **Выбор по локали**: Получайте паттерны по коду локали с
  `LanguagePattern.fromLocale()`
- **Настраиваемые символы**: Определите свой собственный набор символов для
  случайной цензуры
- **Обнаружение мата**: Проверяйте, содержит ли текст мат
- **Извлечение матерных слов**: Извлекайте список найденного мата
- **Неизменяемый дизайн**: `regenerate()` возвращает новые экземпляры
- **Сохранение регистра**: Отцензурированный текст сохраняет исходный регистр
- **Многоязычная поддержка**: Встроенные паттерны для 14 языков с поддержкой
  Unicode

## Что нового в v2.0.0

### Фабричные конструкторы

- ✅ **`CensorIt.random()`** - Замена случайными символами
- ✅ **`CensorIt.mask()`** - Простая маскировка символами
- ✅ **`CensorIt.builder()`** - Пользовательская логика замены
- ✅ **`CensorIt.replace()`** - Замена фиксированной строкой

### Улучшения паттернов

- ✅ **Переименовано в `LanguagePattern`** - Лучшее семантическое название
- ✅ **Выбор по локали** - `fromLocale()` и `fromLocales()`
- ✅ **Улучшенное комбинирование** - `CensorPattern.multi([...])`

### Исправления багов

- ✅ **Исправлена ошибка фабричных конструкторов** - Независимые экземпляры
- ✅ **Сохранение регистра** - Корректная обработка верхнего/нижнего регистра
- ✅ **Неизменяемая перегенерация** - `regenerate()` возвращает новый объект

Смотрите [MIGRATION.md](MIGRATION.md) для инструкций по обновлению.

## История изменений

Список изменений доступен в файле [CHANGELOG.md](CHANGELOG.md)

## Участие в разработке

Не стесняйтесь вносить вклад в этот проект. Если вы нашли баг или хотите
добавить новую функцию, но не знаете, как это исправить/реализовать, пожалуйста,
напишите в [issues](https://github.com/pavluke/censor_it/issues). Если вы
исправили баг или реализовали какую-то функцию, пожалуйста, сделайте
[pull request](https://github.com/pavluke/censor_it/pulls).

## Лицензия

MIT License - подробности в файле [LICENSE.md](LICENSE.md)
