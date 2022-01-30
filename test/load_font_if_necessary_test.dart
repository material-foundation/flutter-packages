import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/src/asset_manifest.dart';
import 'package:google_fonts/src/google_fonts_base.dart';
import 'package:google_fonts/src/google_fonts_descriptor.dart';
import 'package:google_fonts/src/google_fonts_family_with_variant.dart';
import 'package:google_fonts/src/google_fonts_variant.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHttpClient extends Mock implements http.Client {
  Future<http.Response> gets(dynamic uri, {dynamic headers}) {
    super.noSuchMethod(Invocation.method(#get, [uri], {#headers: headers}));
    return Future.value(http.Response('', 200));
  }
}

class MockAssetManifest extends Mock implements AssetManifest {}

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  FakePathProviderPlatform(this._applicationSupportPath);

  final String _applicationSupportPath;

  @override
  Future<String?> getApplicationSupportPath() async {
    return _applicationSupportPath;
  }
}

const _fakeResponse = 'fake response body - success';
// The number of bytes in _fakeResponse.
const _fakeResponseLengthInBytes = 28;
// Computed by converting _fakeResponse to bytes and getting sha 256 hash.
const _fakeResponseHash =
    '1194f6ffe4d2f05258573616a77932c38041f3102763096c19437c3db1818a04';
final _fakeResponseFile = GoogleFontsFile(
  _fakeResponseHash,
  _fakeResponseLengthInBytes,
);

var printLog = <String>[];

void overridePrint(Future<void> Function() testFn) => () {
      var spec = ZoneSpecification(print: (_, __, ___, msg) {
        // Add to log instead of printing to stdout
        printLog.add(msg);
      });
      return Zone.current.fork(specification: spec).run(testFn);
    };

void main() {
  late Directory directory;
  late MockHttpClient _httpClient;

  setUp(() async {
    _httpClient = MockHttpClient();
    httpClient = _httpClient;
    assetManifest = MockAssetManifest();
    GoogleFonts.config.allowRuntimeFetching = true;
    when(_httpClient.gets(any)).thenAnswer((_) async {
      return http.Response(_fakeResponse, 200);
    });

    directory = await Directory.systemTemp.createTemp();
    PathProviderPlatform.instance = FakePathProviderPlatform(directory.path);
  });

  tearDown(() {
    try {
      directory.deleteSync(recursive: true);
    } catch (e) {
      // Swallow errors on Windows, see https://github.com/flutter/flutter/issues/51421.
      if (!Platform.isWindows) rethrow;
    }
    printLog.clear();
    clearCache();
  });

  test('loadFontIfNecessary method calls http get', () async {
    final fakeDescriptor = GoogleFontsDescriptor(
      familyWithVariant: const GoogleFontsFamilyWithVariant(
          family: 'Foo',
          googleFontsVariant: GoogleFontsVariant(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          )),
      file: _fakeResponseFile,
    );

    await loadFontIfNecessary(fakeDescriptor);

    verify(_httpClient.gets(anything)).called(1);
  });

  test('loadFontIfNecessary method throws if font cannot be loaded', () async {
    // Mock a bad response.
    when(_httpClient.gets(any)).thenAnswer((_) async {
      return http.Response('fake response body - failure', 300);
    });

    final descriptorInAssets = GoogleFontsDescriptor(
      familyWithVariant: const GoogleFontsFamilyWithVariant(
        family: 'Foo',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
        ),
      ),
      file: _fakeResponseFile,
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

  test('does not call http if config is false', () async {
    final fakeDescriptor = GoogleFontsDescriptor(
      familyWithVariant: const GoogleFontsFamilyWithVariant(
        family: 'Foo',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
      file: _fakeResponseFile,
    );

    GoogleFonts.config.allowRuntimeFetching = false;

    // Call loadFontIfNecessary and verify that it prints an error.
    overridePrint(() async {
      await loadFontIfNecessary(fakeDescriptor);
      expect(printLog.length, 1);
      expect(
        printLog[0],
        startsWith('google_fonts was unable to load font Foo-Regular'),
      );
      expect(
        printLog[0],
        endsWith(
          "Ensure Foo-Regular.otf exists in a folder that is included in your pubspec's assets.",
        ),
      );
    });

    verifyNever(_httpClient.gets(anything));
  });

  test(
      'loadFontIfNecessary method does not make http get request on '
      'subsequent calls', () async {
    final fakeDescriptor = GoogleFontsDescriptor(
      familyWithVariant: const GoogleFontsFamilyWithVariant(
        family: 'Foo',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
      file: _fakeResponseFile,
    );

    // 1st call.
    await loadFontIfNecessary(fakeDescriptor);
    verify(_httpClient.gets(anything)).called(1);

    // 2nd call.
    await loadFontIfNecessary(fakeDescriptor);
    verifyNever(_httpClient.gets(anything));

    // 3rd call.
    await loadFontIfNecessary(fakeDescriptor);
    verifyNever(_httpClient.gets(anything));
  });

  test(
      'loadFontIfNecessary does not make more than 1 http get request on '
      'parallel calls', () async {
    final fakeDescriptor = GoogleFontsDescriptor(
      familyWithVariant: const GoogleFontsFamilyWithVariant(
        family: 'Foo',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
      file: _fakeResponseFile,
    );

    await Future.wait([
      loadFontIfNecessary(fakeDescriptor),
      loadFontIfNecessary(fakeDescriptor),
      loadFontIfNecessary(fakeDescriptor)
    ]);
    verify(_httpClient.gets(anything)).called(1);
  });

  test('loadFontIfNecessary makes second attempt if the first attempt failed ',
      () async {
    final fakeDescriptor = GoogleFontsDescriptor(
      familyWithVariant: const GoogleFontsFamilyWithVariant(
        family: 'Foo',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
      file: _fakeResponseFile,
    );

    // Have the first call throw an error.
    when(_httpClient.gets(any)).thenThrow('error');
    await loadFontIfNecessary(fakeDescriptor);
    verify(_httpClient.gets(any)).called(1);

    // The second call will retry the http fetch.
    when(_httpClient.gets(any)).thenAnswer((_) async {
      return http.Response(_fakeResponse, 200);
    });
    await loadFontIfNecessary(fakeDescriptor);
    verify(_httpClient.gets(any)).called(1);
  });

  test('loadFontIfNecessary method writes font file', () async {
    final fakeDescriptor = GoogleFontsDescriptor(
      familyWithVariant: const GoogleFontsFamilyWithVariant(
          family: 'Foo',
          googleFontsVariant: GoogleFontsVariant(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          )),
      file: _fakeResponseFile,
    );

    var directoryContents = await getApplicationSupportDirectory();
    expect(directoryContents.listSync().isEmpty, isTrue);

    await loadFontIfNecessary(fakeDescriptor);
    // Give enough time for the file to be saved
    await Future.delayed(const Duration(seconds: 1), () {});
    directoryContents = await getApplicationSupportDirectory();

    expect(directoryContents.listSync().isNotEmpty, isTrue);
    expect(
      directoryContents.listSync().single.toString().contains('Foo'),
      isTrue,
    );
  });

  test(
      'loadFontIfNecessary does not save anything to disk if the file does not '
      'match the expected hash', () async {
    when(_httpClient.gets(any)).thenAnswer((_) async {
      return http.Response('malicious intercepted response', 200);
    });
    final fakeDescriptor = GoogleFontsDescriptor(
      familyWithVariant: const GoogleFontsFamilyWithVariant(
        family: 'Foo',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
      file: _fakeResponseFile,
    );

    var directoryContents = await getApplicationSupportDirectory();
    expect(directoryContents.listSync().isEmpty, isTrue);

    await loadFontIfNecessary(fakeDescriptor);
    directoryContents = await getApplicationSupportDirectory();
    expect(directoryContents.listSync().isEmpty, isTrue);
  });

  test("loadFontByteData doesn't fail", () {
    expect(
      () async => loadFontByteData('fontFamily', Future.value(ByteData(0))),
      returnsNormally,
    );
    expect(
      () async => loadFontByteData('fontFamily', Future.value(null)),
      returnsNormally,
    );
    expect(
      () async => loadFontByteData('fontFamily', null),
      returnsNormally,
    );

    expect(
      () async => loadFontByteData('fontFamily',
          Future.delayed(const Duration(milliseconds: 100), () => null)),
      returnsNormally,
    );
  });
}
