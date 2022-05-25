Pod::Spec.new do |s|
  s.name             = 'dynamic_color'
  s.authors          = 'Material Flutter team + Ebrahim Byagowi'
  s.license          = 'BSD-3-Clause'
  s.homepage         = 'https://github.com/material-foundation/material-dynamic-color-flutter'
  s.summary          = 'Retrieves control accent color'
  s.version          = '0.0.1'
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
