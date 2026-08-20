# dynamic_color_testing

A Flutter package with test utilities for [dynamic_color](https://pub.dev/packages/dynamic_color).

Use this package in widget tests to mock platform-provided dynamic color values without changing a device wallpaper or accent color.

## Installation

```sh
flutter pub add --dev dynamic_color_testing
```

## Import

```dart
import 'package:dynamic_color_testing/dynamic_color_testing.dart';
```

## What this package provides

- `DynamicColorTestingUtils.setMockDynamicColors(...)`
  - Mocks dynamic color platform channel responses.
  - Supports `corePalette` and `accentColor`.
  - Automatically resets the mock with `addTearDown`.
- `SampleCorePalettes`
  - Predefined core palettes for common test scenarios.
- `SampleColorSchemes`
  - Color schemes derived from sample palettes.
- `generateCorePalette(...)`
  - Helper to generate custom `CorePalette` values.

## Example

```dart
import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_testing/dynamic_color_testing.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Reset mock values for every test.
  setUp(() => DynamicColorTestingUtils.setMockDynamicColors());

  testWidgets('uses mocked dynamic core palette', (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(
      corePalette: SampleCorePalettes.green,
    );

    await tester.pumpWidget(
      DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) => Container(
          color: lightDynamic?.primary ?? Colors.red,
        ),
      ),
    );

    await tester.pumpAndSettle();
  });
}
```

For a full example, see the dynamic_color example test:
https://github.com/material-foundation/flutter-packages/blob/main/packages/dynamic_color/example/test/widget_test.dart
