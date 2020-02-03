import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/src/google_fonts_base.dart';
import 'package:google_fonts/src/google_fonts_descriptor.dart';
import 'package:google_fonts/src/google_fonts_family_with_variant.dart';
import 'package:google_fonts/src/google_fonts_variant.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MockHttpClient extends Mock implements http.Client {}

var printLog = [];
overridePrint(testFn()) => () {
      var spec = new ZoneSpecification(print: (_, __, ___, String msg) {
        // Add to log instead of printing to stdout
        printLog.add(msg);
      });
      return Zone.current.fork(specification: spec).run(testFn);
    };

main() {
  setUp(() async {
    httpClient = MockHttpClient();
    GoogleFonts.config.allowHttp = true;
    when(httpClient.get(any)).thenAnswer((_) async {
      return http.Response('fake response body - success', 200);
    });

    // The following snippet pulled from
    //  * https://flutter.dev/docs/cookbook/persistence/reading-writing-files#testing
    final directory = await Directory.systemTemp.createTemp();
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((methodCall) async {
      if (methodCall.method == 'getApplicationSupportDirectory') {
        return directory.path;
      }
      return null;
    });
  });

  tearDown(() {
    printLog = [];
    clearCache();
  });

  testWidgets('loadFontIfNecessary method calls http get', (tester) async {
    final fakeUrl = Uri.http('fonts.google.com', '/Foo');
    final fakeDescriptor = GoogleFontsDescriptor(
      familyWithVariant: GoogleFontsFamilyWithVariant(
          family: 'Foo',
          googleFontsVariant: GoogleFontsVariant(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          )),
      fontUrl: fakeUrl.toString(),
    );

    await loadFontIfNecessary(fakeDescriptor);

    verify(httpClient.get(fakeUrl)).called(1);
  });

  testWidgets('loadFontIfNecessary method throws if font cannot be loaded',
      (tester) async {
    // Mock a bad response.
    when(httpClient.get(any)).thenAnswer((_) async {
      return http.Response('fake response body - failure', 300);
    });

    final fooUrl = Uri.http('fonts.google.com', '/Foo');
    final descriptorInAssets = GoogleFontsDescriptor(
      familyWithVariant: GoogleFontsFamilyWithVariant(
        family: 'Foo',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
        ),
      ),
      fontUrl: fooUrl.toString(),
    );

    // Call loadFontIfNecessary and verify that it prints an error.
    overridePrint(() async {
      await loadFontIfNecessary(descriptorInAssets);
      expect(printLog.length, 1);
      expect(
        printLog[0],
        startsWith('google_fonts was unable to load font Foo-BlackItalic'),
      );
    });
  });

  testWidgets('does not call http if config is false', (tester) async {
    final fakeUrl = Uri.http('fonts.google.com', '/Foo');
    final fakeDescriptor = GoogleFontsDescriptor(
      familyWithVariant: GoogleFontsFamilyWithVariant(
        family: 'Foo',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
      fontUrl: fakeUrl.toString(),
    );

    GoogleFonts.config.allowHttp = false;

    // Call loadFontIfNecessary and verify that it prints an error.
    overridePrint(() async {
      await loadFontIfNecessary(fakeDescriptor);
      expect(printLog.length, 1);
      expect(
        printLog[0],
        startsWith("google_fonts was unable to load font Foo-Regular"),
      );
      expect(
        printLog[0],
        endsWith(
          "Ensure Foo-Regular.otf exists in a folder that is included in your pubspec's assets.",
        ),
      );
    });

    verifyNever(httpClient.get(anything));
  });

  testWidgets(
      'loadFontIfNecessary method does not make http get request on '
      'subsequent calls', (tester) async {
    final fakeUrl = Uri.http('fonts.google.com', '/Foo');
    final fakeDescriptor = GoogleFontsDescriptor(
      familyWithVariant: GoogleFontsFamilyWithVariant(
        family: 'Foo',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
      fontUrl: fakeUrl.toString(),
    );

    // 1st call.
    await loadFontIfNecessary(fakeDescriptor);
    verify(httpClient.get(fakeUrl)).called(1);

    // 2nd call.
    await loadFontIfNecessary(fakeDescriptor);
    verifyNever(httpClient.get(fakeUrl));

    // 3rd call.
    await loadFontIfNecessary(fakeDescriptor);
    verifyNever(httpClient.get(fakeUrl));
  });

  testWidgets('loadFontIfNecessary method writes font file', (tester) async {
    final fakeUrl = Uri.http('fonts.google.com', '/Foo');
    final fakeDescriptor = GoogleFontsDescriptor(
      familyWithVariant: GoogleFontsFamilyWithVariant(
          family: 'Foo',
          googleFontsVariant: GoogleFontsVariant(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          )),
      fontUrl: fakeUrl.toString(),
    );

    var directoryContents = await getApplicationSupportDirectory();
    expect(directoryContents.listSync().isEmpty, isTrue);

    await loadFontIfNecessary(fakeDescriptor);
    directoryContents = await getApplicationSupportDirectory();

    expect(directoryContents.listSync().isNotEmpty, isTrue);
    expect(
      directoryContents.listSync().single.toString().contains('Foo'),
      isTrue,
    );
  });

  testWidgets(
      'loadFontIfNecessary method does nothing if the font is in the '
      'Asset Manifest', (tester) async {
    // Add Foo-BlackItalic to mock asset bundle.
    ServicesBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) {
      final Uint8List encoded =
          utf8.encoder.convert('{"google_fonts/Foo-BlackItalic.ttf":'
              '["google_fonts/Foo-BlackItalic.ttf"]}');
      return Future.value(encoded.buffer.asByteData());
    });

    final fooUrl = Uri.http('fonts.google.com', '/Foo');
    final descriptorInAssets = GoogleFontsDescriptor(
      familyWithVariant: GoogleFontsFamilyWithVariant(
        family: 'Foo',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
        ),
      ),
      fontUrl: fooUrl.toString(),
    );

    // Call loadFontIfNecessary and verify no http request happens because
    // Foo-BlackItalic is in the asset bundle.
    await loadFontIfNecessary(descriptorInAssets);
    verifyNever(httpClient.get(fooUrl));

    final barUrl = Uri.http('fonts.google.com', '/Bar');
    final descriptorNotInAssets = GoogleFontsDescriptor(
      familyWithVariant: GoogleFontsFamilyWithVariant(
        family: 'Bar',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
        ),
      ),
      fontUrl: barUrl.toString(),
    );

    // Call loadFontIfNecessary and verify that an http request happens because
    // Bar-BoldItalic is in the asset bundle.
    await loadFontIfNecessary(descriptorNotInAssets);
    verify(httpClient.get(barUrl)).called(1);
  });
}
