import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/src/google_fonts_base.dart';
import 'package:google_fonts/src/google_fonts_descriptor.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MockHttpClient extends Mock implements http.Client {}

main() {
  setUp(() async {
    httpClient = MockHttpClient();
    when(httpClient.get(any)).thenAnswer((_) async {
      return http.Response('fake response body - success', 200);
    });

    // The following snippet pulled from
    //  * https://flutter.dev/docs/cookbook/persistence/reading-writing-files#testing
    final directory = await Directory.systemTemp.createTemp();
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      return null;
    });
  });

  tearDown(() {
    clearCache();
  });

  testWidgets('loadFontIfNeccessary method calls http get', (tester) async {
    final fakeUrl = Uri.http('fonts.google.com', '/foo');
    final fakeDescriptor = GoogleFontsDescriptor(
      fontFamily: 'foo',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontUrl: fakeUrl.toString(),
    );

    await loadFontIfNecessary(fakeDescriptor);

    verify(httpClient.get(fakeUrl)).called(1);
  });

  testWidgets(
      'loadFontIfNeccessary method does not make http get request on '
      'subsequent calls', (tester) async {
    final fakeUrl = Uri.http('fonts.google.com', '/foo');
    final fakeDescriptor = GoogleFontsDescriptor(
      fontFamily: 'foo',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
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

  testWidgets('loadFontIfNeccessary method writes font file', (tester) async {
    final fakeUrl = Uri.http('fonts.google.com', '/foo');
    final fakeDescriptor = GoogleFontsDescriptor(
      fontFamily: 'foo',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontUrl: fakeUrl.toString(),
    );

    var directoryContents = await getApplicationDocumentsDirectory();
    expect(directoryContents.listSync().isEmpty, isTrue);

    await loadFontIfNecessary(fakeDescriptor);
    directoryContents = await getApplicationDocumentsDirectory();

    expect(directoryContents.listSync().isNotEmpty, isTrue);
    expect(
      directoryContents.listSync().single.toString().contains('foo'),
      isTrue,
    );
  });
}
