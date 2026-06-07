<p align="center">
  <img src="https://github.com/Pavluke/censor_it/blob/main/images/banner.png?raw=true" alt="Banner" />
</p>

[![Pub](https://img.shields.io/pub/v/censor_it.svg)](https://pub.dartlang.org/packages/censor_it)

**En** | [Ru](README_RU.md)

Dart library for censoring text based on predefined patterns and customizable
characters.

## Migration Guide

Upgrading from v1.x? See the detailed [Migration Guide](MIGRATION.md) for
step-by-step instructions.

## 🚀 Flutter Integration:

For Flutter applications, use the package `censor_it_flutter`
[GitHub](https://github.com/pavluke/censor_it_flutter) |
[Pub.dev](https://pub.dev/packages/censor_it_flutter)

## Introduction

When it comes to censoring text in your Dart application, you might need to
handle multiple languages and customize the characters used for censoring.
`CensorIt` provides an easy-to-use solution with multiple censoring strategies.

## Supported languages

- 🇨🇳 Chinese (ZH)
- 🇺🇸 English (EN)
- 🇫🇮 Finnish (FI)
- 🇫🇷 French (FR)
- 🇩🇪 German (DE)
- 🇮🇹 Italian (IT)
- 🇰🇿 Kazakh (KK)
- 🇰🇷 Korean (KO)
- 🇱🇻 Latvian (LV)
- 🇱🇹 Lithuanian (LT)
- 🇵🇹 Portuguese (PT)
- 🇵🇱 Polish (PL)
- 🇷🇺 Russian (RU)
- 🇪🇸 Spanish (ES)
- 🇸🇪 Swedish (SV)
- 🇺🇦 Ukrainian (UK)

## Getting started

Add censor_it to your `pubspec.yaml`:

```yaml
dependencies:
  censor_it: ^2.1.2
```

Or using the command:

```bash
dart pub add censor_it
```

Import the package in your Dart file:

```dart
import 'package:censor_it/censor_it.dart';
```

## Usage

### Basic Example

```dart
void main() {
  const String text = '''
I don't give a fuck that there are a lot of obscene words here!
I'm sure the developer of this lib is an asshole!''';

  // Create an instance with mask censoring
  final censoredText = CensorIt.mask(text, pattern: LanguagePattern.english);

  // Get the censored text
  print(censoredText.censored);
  // Output: I don't give a **** that there are a lot of obscene words here!
  // I'm sure the developer of this lib is an *******!

  // Check if the text contains profanity
  print(censoredText.hasProfanity); // Output: true

  // Get a list of swear words found in the text
  print(censoredText.swearWords); // Output: [fuck, asshole]
}
```

## Factory Constructors (v2.0.0+)

CensorIt v2.0.0 introduces four factory constructors for different censoring
strategies:

### 1. CensorIt.random() - Random Character Replacement

Replaces profanity with random characters from a customizable set.

```dart
final random = CensorIt.random(
  'fuck this',
  pattern: LanguagePattern.english,
  chars: ['!', '#', '%', '&', '?', '@', '\$'],
);
print(random.censored); // !@#$ this
```

**Use case:** Dynamic, varied censoring that looks different each time.

### 2. CensorIt.mask() - Simple Character Masking

Replaces profanity by repeating a single character.

```dart
final masked = CensorIt.mask(
  'fuck this',
  char: '*',
  pattern: LanguagePattern.english,
);
print(masked.censored); // **** this
```

**Use case:** Clean, consistent masking without randomness.

### 3. CensorIt.builder() - Custom Replacement Logic

Provides complete control over replacement with a builder function.

```dart
// Replace with word length
final lengthBased = CensorIt.builder(
  'fucking shit, fuck this',
  builder: (word) => '[${word.length}]',
  pattern: LanguagePattern.english,
);
print(lengthBased.censored); // [7] [4], [4] this

// Conditional replacement
final conditional = CensorIt.builder(
  'fucking shit, fuck this',
  builder: (word) => word.length > 4 ? '*******' : '***',
  pattern: LanguagePattern.english,
);
print(conditional.censored); // ******* ***, *** this
```

**Use case:** Complex logic, analytics, or custom formatting needs.

### 4. CensorIt.replace() - Fixed String Replacement

Replaces all profanity with the same fixed string.

```dart
final fixed = CensorIt.replace(
  'fucking shit!',
  replacement: '[censored]',
  pattern: LanguagePattern.english,
);
print(fixed.censored); // [censored] [censored]!

// Case preservation
final preserved = CensorIt.replace(
  'fuck this',
  replacement: 'BEEP',
  pattern: LanguagePattern.english,
);
print(preserved.censored); // BEEP this
```

**Use case:** Consistent, readable replacements across all profanity.

## Language Patterns

### Using Predefined Patterns

```dart
// Single language
final english = CensorIt.mask('fuck this', pattern: LanguagePattern.english);
final russian = CensorIt.mask('это пиздец', pattern: LanguagePattern.russian);

// All languages at once
final allLangs = CensorIt.mask('fuck this, блять', pattern: LanguagePattern.all);
```

### Combining Multiple Languages

```dart
// Combine specific languages
final multiLang = CensorIt.mask(
  'fuck this puta',
  pattern: CensorPattern.multi([
    LanguagePattern.english,
    LanguagePattern.spanish,
  ]),
);
```

### Locale-Based Pattern Selection (v2.0.0+)

```dart
// Get pattern by locale code
final latvian = LanguagePattern.fromLocale('lv');
final censor = CensorIt.mask('pizdets', pattern: latvian);

// With fallback
final pattern = LanguagePattern.fromLocale(
  'unknown',
  fallback: LanguagePattern.russian,
);

// Multiple locales
final multi = LanguagePattern.fromLocales(['en', 'es']);
final censor = CensorIt.mask('fuck this puta ', pattern: multi);
```

### Custom Patterns

```dart
// Create custom pattern with RegExp
final customPattern = CensorPattern.fromRegExp(
  RegExp(r'badword|anotherbad', caseSensitive: false),
);
final censor = CensorIt.mask('badword here', pattern: customPattern);
```

## Using String Extensions

```dart
final text = 'fuck this';

// Get censored string directly
print(text.censored(pattern: LanguagePattern.english));
// Output: **** this
```

## Regenerating Censored Text (CensorIt.random only)

```dart
final censor1 = CensorIt.random('fuck', pattern: LanguagePattern.english);
print(censor1.censored); // @#%!

// Create new instance with different random censoring
final censor2 = censor1.regenerate();
print(censor2.censored); // %&!# (different)
print(censor1.censored); // @#%! (original unchanged)
```

**Note:** `regenerate()` is only available for `CensorIt.random()` instances.

## Features

- **Multiple Censoring Strategies**: Choose from random, mask, builder, or
  replace
- **Factory Constructors**: Clean API with `CensorIt.random()`,
  `CensorIt.mask()`, etc.
- **Customizable Patterns**: Use predefined patterns or create your own with
  `CensorPattern.fromRegExp()`
- **Locale-Based Selection**: Get patterns by locale code with
  `LanguagePattern.fromLocale()`
- **Customizable Characters**: Define your own set of characters for random
  censoring
- **Profanity Detection**: Check if text contains profanity
- **Swear Words Extraction**: Extract list of found profanity
- **Immutable Design**: `regenerate()` returns new instances
- **Case Preservation**: Censored text maintains original case
- **Multilingual Support**: Built-in patterns for 14 languages with Unicode
  support

## What's New in v2.0.0

### Factory Constructors

- ✅ **`CensorIt.random()`** - Random character replacement
- ✅ **`CensorIt.mask()`** - Simple character masking
- ✅ **`CensorIt.builder()`** - Custom replacement logic
- ✅ **`CensorIt.replace()`** - Fixed string replacement

### Pattern Improvements

- ✅ **Renamed to `LanguagePattern`** - Better semantic naming
- ✅ **Locale-based selection** - `fromLocale()` and `fromLocales()`
- ✅ **Better combining** - `CensorPattern.multi([...])`

### Bug Fixes

- ✅ **Fixed factory constructor bug** - Independent instances
- ✅ **Case preservation** - Correct uppercase/lowercase handling
- ✅ **Immutable regeneration** - `regenerate()` returns new object

See [MIGRATION.md](MIGRATION.md) for upgrade instructions.

## Changelog

The list of changes is available in the file [CHANGELOG.md](CHANGELOG.md)

## Contributions

Feel free to contribute to this project. If you find a bug or want to add a new
feature but don't know how to fix/implement it, please write in
[issues](https://github.com/pavluke/censor_it/issues). If you fixed a bug or
implemented some feature, please make
[pull request](https://github.com/pavluke/censor_it/pulls).

## License

MIT License - see [LICENSE.md](LICENSE.md) file for details
