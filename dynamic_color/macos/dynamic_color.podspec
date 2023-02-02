Pod::Spec.new do |s|
  s.name             = 'dynamic_color'
  s.authors          = 'Material Flutter team + Ebrahim Byagowi'
  s.license          = 'BSD-3-Clause'
  s.homepage         = 'https://github.com/material-foundation/flutter-packages/tree/main/packages/dynamic_color'
  s.summary          = 'Retrieves accent color'
  s.version          = '0.0.2'
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
