import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_test/flutter_test.dart';

/// Stands in for the native side of [DynamicColorPlugin.accentColorChannel].
class AccentColorStreamMock {
  AccentColorStreamMock() {
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockStreamHandler(
      DynamicColorPlugin.accentColorChannel,
      MockStreamHandler.inline(
        onListen: (Object? arguments, MockStreamHandlerEventSink events) {
          _events = events;
          listenCount++;
        },
        onCancel: (Object? arguments) {
          _events = null;
          cancelCount++;
        },
      ),
    );
    addTearDown(() {
      messenger.setMockStreamHandler(
        DynamicColorPlugin.accentColorChannel,
        null,
      );
    });
  }

  MockStreamHandlerEventSink? _events;
  int listenCount = 0;
  int cancelCount = 0;

  void emit(int argb) => _events!.success(argb);
}
