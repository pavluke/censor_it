## 2.2.0

### Added

- **`String.censor()` extension** - Replaces `String.censored()` (random
  character replacement). The new name no longer looks like the `censored`
  getter of `CensorIt`, which does a different job

### Deprecated

- **`String.censored()` extension** - Use `String.censor()` instead

### Fixed

- **False positives in `LanguagePattern.all`** - Ordinary words such as
  `customer`, `cute`, `cup`, `horizon`, `vitamin`, `pistol`, `Pisa` and Russian
  `себя`/`себе` are no longer detected as profanity:
  - Portuguese: `cu` matches only `cu`, `cuzão` and `cuzona`, not every `cu*`
  - Finnish: `vitt?u*` instead of `vit*`
  - Swedish: explicit `hora`/`horor`/`horunge` forms instead of `hor*`
  - Latvian: `pistol`, `piston`, `pistachio` and `Pisa` no longer match
  - Russian: the bare prefix `с` no longer combines with the `еб` root
    (`съебать` is still detected)
  - Italian: `cazzuola`, `stronzio`; French: `salopette`
- **`CensorPattern.multi([])`** - An empty list now matches nothing. Previously
  the combined regular expression matched an empty string at every position, so
  any text was reported as profane
- **Documentation examples** - `CensorIt.random` example in `README_RU.md`
  (`r'\$'` is two characters and threw `ArgumentError`), output of the string
  extension, number of supported languages, snippets in `MIGRATION.md`

### Changed

- **Performance** - Language regular expressions are compiled once instead of on
  every access. The combined regular expression of `CensorPattern.multi` is
  built once per instance, `LanguagePattern.fromLocales` memoizes the combined
  pattern, and `matches` is computed once per `CensorIt` instance (`hasProfanity`
  and `swearWords` reuse it)
- **`GetMatchesX.matches` returns an unmodifiable list**
- **`CensorPattern.multi` treats `patterns` as immutable** - The list must not
  be modified after the first use of `regExp`

## 2.1.3

- Downgrade [meta](https://pub.dev/packages/meta) to ^1.18.0

## 2.1.2

- Add [pavluke_lints](https://pub.dev/packages/pavluke_lints)

## 2.1.1

- Downgrade min requirement Dart SDK to 3.6.0
- Replace ccTLD codes with ISO 639-1 language codes

## 2.1.0

### Added

- **🇨🇳 Chinese (Mandarin) language support**
- **🇰🇷 Korean language support**

### Fixed

- **`CensorItRandom.regenerate()` collision prevention** - Now guarantees
  different censored text in 99.99% of cases

## 2.0.0

### Breaking Changes

- **Main constructor replaced with factory constructors** - Use
`CensorIt.random()`, `CensorIt.mask()`, `CensorIt.builder()`, or
`CensorIt.replace()`
- **`CensorPattern` renamed to `LanguagePattern`** - Better semantic naming
- **Changed from `enum` to `sealed class`** - Better type safety and
  extensibility
- **Removed `regenerateCensoredText()`** - Use `regenerate()` instead (only for
`CensorIt.random()`)
- **Removed `toCensorIt()` extension** - Use factory constructors directly
- **`fromPatterns()` renamed to `multi()`** - `CensorPattern.multi([...])`
- **SDK minimum version raised to `^3.10.0`**

### Added

- **`CensorIt.random()` factory** - Random character replacement (replaces old
  constructor)
- **`CensorIt.mask()` factory** - Simple character masking (e.g., `****`)
- **`CensorIt.builder()` factory** - Custom replacement logic with builder
  function
- **`CensorIt.replace()` factory** - Fixed string replacement (e.g.,
`[censored]`)
- **Locale-based pattern selection** - `LanguagePattern.fromLocale('lv')`
- **Multi-locale patterns** - `LanguagePattern.fromLocales(['en', 'ru', 'es'])`
- **Simplified `.censored()` extension** - Direct string censoring
- **`CensorIt.defaultChars` constant** - Reference default censoring characters
- **Better validation** - Validates single-character elements and non-empty
  lists

### Fixed

- **Case preservation bug** - Censored text now correctly maintains original
  case
- **Custom pattern independence** - Each custom pattern has its own RegExp
  instance
- **Factory constructor bug** - Multiple calls no longer interfere with each
  other
- **Infinite loop protection** - Added fallback mechanism for edge cases

### Changed

- Constructor replaced with factory methods for different strategies
- Pattern class renamed: `CensorPattern` → `LanguagePattern`
- Combining patterns: `fromPatterns()` → `CensorPattern.multi()`
- File structure reorganized into `core/`, `patterns/`, `extensions/`

### Removed

- `toCensorIt()` extension method
- Default `CensorIt()` constructor
- `regenerateCensoredText()` method

### Migration Guide

See [MIGRATION.md](MIGRATION.md) for detailed step-by-step instructions.

---

## 1.2.4

- Set type annotation on CensorPattern static methods
- Update README.md
- Update example
- Update pubspec.yaml

## 1.2.3

- Update README.md

## 1.2.2

- Update README.md

## 1.2.1

- Update README.md
- Update LICENSE
- Update example

## 1.2.0

- Refactored regexps
- Added regexps tests
- Deprecated stream

## 1.1.1

- Update README.md

## 1.1.0

- Added extension [CensorIt] on [String]

## 1.0.4

- Enum changes

## 1.0.3

- Removed bang operator

## 1.0.2

- Updated docs.

## 1.0.1

- Updated docs.

## 1.0.0

- Initial version.
