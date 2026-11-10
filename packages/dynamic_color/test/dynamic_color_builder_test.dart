import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_testing/dynamic_color_testing.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'accent_color_stream_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    DynamicColorTestingUtils.setMockDynamicColors(
      corePalette: SampleCorePalettes.green,
      accentColor: Colors.amber,
    );
  });

  const containerKey = Key('myContainer');

  Widget dynamicColorBuilder() => DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return Container(
            key: containerKey,
            color: lightDynamic?.primary ?? const Color(0x00000123),
          );
        },
      );

  testWidgets('DynamicColorBuilder is correct on Android',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(
      corePalette: SampleCorePalettes.green,
    );

    await tester.pumpWidget(dynamicColorBuilder());
    await tester.pumpAndSettle();

    final container = tester.firstWidget(find.byKey(containerKey)) as Container;
    expect(container.color, const Color(0xff286c2a));
  });

  testWidgets('DynamicColorBuilder is correct on desktop',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(
      accentColor: Colors.amber,
    );
    await tester.pumpWidget(dynamicColorBuilder());
    await tester.pumpAndSettle();

    final container = tester.firstWidget(find.byKey(containerKey)) as Container;
    expect(container.color, const Color(0xff775a0b));
  });

  testWidgets('DynamicColorBuilder is correct on other platforms',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors();

    await tester.pumpWidget(dynamicColorBuilder());
    await tester.pumpAndSettle();

    final container = tester.firstWidget(find.byKey(containerKey)) as Container;
    expect(container.color, const Color(0x00000123));
  });

  group('accent color changes on Linux', () {
    const initial = Color(0xFF112233);
    const changed = Color(0xFF445566);
    const changedArgb = 0xFF445566;

    Color primaryFor(Color seed) => ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ).primary;

    Color? shownColor(WidgetTester tester) =>
        (tester.firstWidget(find.byKey(containerKey)) as Container).color;

    final linux = TargetPlatformVariant.only(TargetPlatform.linux);

    testWidgets('update the color schemes', (WidgetTester tester) async {
      DynamicColorTestingUtils.setMockDynamicColors(accentColor: initial);
      final mock = AccentColorStreamMock();

      await tester.pumpWidget(dynamicColorBuilder());
      await tester.pumpAndSettle();
      expect(shownColor(tester), primaryFor(initial));

      mock.emit(changedArgb);
      await tester.pumpAndSettle();
      expect(shownColor(tester), primaryFor(changed));
    }, variant: linux);

    testWidgets('are kept when they arrive during the first read',
        (WidgetTester tester) async {
      final firstRead = Completer<int>();
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      messenger.setMockMethodCallHandler(DynamicColorPlugin.channel,
          (MethodCall call) async {
        return call.method == DynamicColorPlugin.accentColorMethodName
            ? firstRead.future
            : null;
      });
      addTearDown(() {
        messenger.setMockMethodCallHandler(DynamicColorPlugin.channel, null);
      });
      final mock = AccentColorStreamMock();

      await tester.pumpWidget(dynamicColorBuilder());
      await tester.pump();

      mock.emit(changedArgb);
      await tester.pump();
      firstRead.complete(0xFF112233);
      await tester.pumpAndSettle();

      expect(shownColor(tester), primaryFor(changed));
    }, variant: linux);

    testWidgets('stop when the widget is removed', (WidgetTester tester) async {
      DynamicColorTestingUtils.setMockDynamicColors(accentColor: initial);
      final mock = AccentColorStreamMock();

      await tester.pumpWidget(dynamicColorBuilder());
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();

      expect([mock.listenCount, mock.cancelCount], [1, 1]);
    }, variant: linux);
  });

  testWidgets('does not listen for accent color changes on other platforms',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(accentColor: Colors.amber);
    final mock = AccentColorStreamMock();

    await tester.pumpWidget(dynamicColorBuilder());
    await tester.pumpAndSettle();

    expect(mock.listenCount, 0);
  }, variant: TargetPlatformVariant.only(TargetPlatform.android));
}
