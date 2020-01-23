///
//  Generated code. Do not modify.
//  source: fonts.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class FileSpec extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FileSpec',
      package: const $pb.PackageName('fonts'), createEmptyInstance: create)
    ..aOS(1, 'filename')
    ..aInt64(2, 'fileSize')
    ..a<$core.List<$core.int>>(3, 'hash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  FileSpec._() : super();
  factory FileSpec() => create();
  factory FileSpec.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FileSpec.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  FileSpec clone() => FileSpec()..mergeFromMessage(this);
  FileSpec copyWith(void Function(FileSpec) updates) =>
      super.copyWith((message) => updates(message as FileSpec));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileSpec create() => FileSpec._();
  FileSpec createEmptyInstance() => create();
  static $pb.PbList<FileSpec> createRepeated() => $pb.PbList<FileSpec>();
  @$core.pragma('dart2js:noInline')
  static FileSpec getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileSpec>(create);
  static FileSpec _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get filename => $_getSZ(0);
  @$pb.TagNumber(1)
  set filename($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFilename() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilename() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get fileSize => $_getI64(1);
  @$pb.TagNumber(2)
  set fileSize($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFileSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get hash => $_getN(2);
  @$pb.TagNumber(3)
  set hash($core.List<$core.int> v) {
    $_setBytes(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearHash() => clearField(3);
}

class IntRange extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('IntRange',
      package: const $pb.PackageName('fonts'), createEmptyInstance: create)
    ..a<$core.int>(1, 'start', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'end', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  IntRange._() : super();
  factory IntRange() => create();
  factory IntRange.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory IntRange.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  IntRange clone() => IntRange()..mergeFromMessage(this);
  IntRange copyWith(void Function(IntRange) updates) =>
      super.copyWith((message) => updates(message as IntRange));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IntRange create() => IntRange._();
  IntRange createEmptyInstance() => create();
  static $pb.PbList<IntRange> createRepeated() => $pb.PbList<IntRange>();
  @$core.pragma('dart2js:noInline')
  static IntRange getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IntRange>(create);
  static IntRange _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get start => $_getIZ(0);
  @$pb.TagNumber(1)
  set start($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get end => $_getIZ(1);
  @$pb.TagNumber(2)
  set end($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);
}

class FloatRange extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FloatRange',
      package: const $pb.PackageName('fonts'), createEmptyInstance: create)
    ..a<$core.double>(1, 'start', $pb.PbFieldType.OF)
    ..a<$core.double>(2, 'end', $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  FloatRange._() : super();
  factory FloatRange() => create();
  factory FloatRange.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FloatRange.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  FloatRange clone() => FloatRange()..mergeFromMessage(this);
  FloatRange copyWith(void Function(FloatRange) updates) =>
      super.copyWith((message) => updates(message as FloatRange));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FloatRange create() => FloatRange._();
  FloatRange createEmptyInstance() => create();
  static $pb.PbList<FloatRange> createRepeated() => $pb.PbList<FloatRange>();
  @$core.pragma('dart2js:noInline')
  static FloatRange getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FloatRange>(create);
  static FloatRange _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get start => $_getN(0);
  @$pb.TagNumber(1)
  set start($core.double v) {
    $_setFloat(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get end => $_getN(1);
  @$pb.TagNumber(2)
  set end($core.double v) {
    $_setFloat(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);
}

class Font extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Font',
      package: const $pb.PackageName('fonts'), createEmptyInstance: create)
    ..aOM<FileSpec>(1, 'file', subBuilder: FileSpec.create)
    ..aOM<IntRange>(2, 'weight', subBuilder: IntRange.create)
    ..aOM<FloatRange>(3, 'width', subBuilder: FloatRange.create)
    ..aOM<FloatRange>(4, 'italic', subBuilder: FloatRange.create)
    ..a<$core.int>(7, 'ttcIndex', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  Font._() : super();
  factory Font() => create();
  factory Font.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Font.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Font clone() => Font()..mergeFromMessage(this);
  Font copyWith(void Function(Font) updates) =>
      super.copyWith((message) => updates(message as Font));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Font create() => Font._();
  Font createEmptyInstance() => create();
  static $pb.PbList<Font> createRepeated() => $pb.PbList<Font>();
  @$core.pragma('dart2js:noInline')
  static Font getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Font>(create);
  static Font _defaultInstance;

  @$pb.TagNumber(1)
  FileSpec get file => $_getN(0);
  @$pb.TagNumber(1)
  set file(FileSpec v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => clearField(1);
  @$pb.TagNumber(1)
  FileSpec ensureFile() => $_ensure(0);

  @$pb.TagNumber(2)
  IntRange get weight => $_getN(1);
  @$pb.TagNumber(2)
  set weight(IntRange v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasWeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearWeight() => clearField(2);
  @$pb.TagNumber(2)
  IntRange ensureWeight() => $_ensure(1);

  @$pb.TagNumber(3)
  FloatRange get width => $_getN(2);
  @$pb.TagNumber(3)
  set width(FloatRange v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => clearField(3);
  @$pb.TagNumber(3)
  FloatRange ensureWidth() => $_ensure(2);

  @$pb.TagNumber(4)
  FloatRange get italic => $_getN(3);
  @$pb.TagNumber(4)
  set italic(FloatRange v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasItalic() => $_has(3);
  @$pb.TagNumber(4)
  void clearItalic() => clearField(4);
  @$pb.TagNumber(4)
  FloatRange ensureItalic() => $_ensure(3);

  @$pb.TagNumber(7)
  $core.int get ttcIndex => $_getIZ(4);
  @$pb.TagNumber(7)
  set ttcIndex($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasTtcIndex() => $_has(4);
  @$pb.TagNumber(7)
  void clearTtcIndex() => clearField(7);
}

class FontFamily extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FontFamily',
      package: const $pb.PackageName('fonts'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..pc<Font>(4, 'fonts', $pb.PbFieldType.PM, subBuilder: Font.create)
    ..hasRequiredFields = false;

  FontFamily._() : super();
  factory FontFamily() => create();
  factory FontFamily.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FontFamily.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  FontFamily clone() => FontFamily()..mergeFromMessage(this);
  FontFamily copyWith(void Function(FontFamily) updates) =>
      super.copyWith((message) => updates(message as FontFamily));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FontFamily create() => FontFamily._();
  FontFamily createEmptyInstance() => create();
  static $pb.PbList<FontFamily> createRepeated() => $pb.PbList<FontFamily>();
  @$core.pragma('dart2js:noInline')
  static FontFamily getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FontFamily>(create);
  static FontFamily _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  @$pb.TagNumber(4)
  $core.List<Font> get fonts => $_getList(2);
}

class Directory extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Directory',
      package: const $pb.PackageName('fonts'), createEmptyInstance: create)
    ..pc<FontFamily>(1, 'family', $pb.PbFieldType.PM,
        subBuilder: FontFamily.create)
    ..p<$core.int>(2, 'nameLookup', $pb.PbFieldType.P3)
    ..pPS(3, 'strings')
    ..p<$core.int>(4, 'prefetch', $pb.PbFieldType.P3)
    ..a<$core.int>(5, 'version', $pb.PbFieldType.O3)
    ..aOS(6, 'description')
    ..hasRequiredFields = false;

  Directory._() : super();
  factory Directory() => create();
  factory Directory.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Directory.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Directory clone() => Directory()..mergeFromMessage(this);
  Directory copyWith(void Function(Directory) updates) =>
      super.copyWith((message) => updates(message as Directory));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Directory create() => Directory._();
  Directory createEmptyInstance() => create();
  static $pb.PbList<Directory> createRepeated() => $pb.PbList<Directory>();
  @$core.pragma('dart2js:noInline')
  static Directory getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Directory>(create);
  static Directory _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FontFamily> get family => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get nameLookup => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get strings => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.int> get prefetch => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get version => $_getIZ(4);
  @$pb.TagNumber(5)
  set version($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersion() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);
}
