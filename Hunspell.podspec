Pod::Spec.new do |s|
  s.name         = 'Hunspell'
  s.version      = '1.0.0'
  s.summary      = 'Hunspell library for iOS'
  s.description  = 'Hunspell library for iOS projects'
  s.homepage     = 'https://github.com/denizmaral/hunspell'
  s.license      = { :type => 'MIT' }
  s.author       = { 'Your Name' => 'you@example.com' }
  s.source       = { :git => 'https://github.com/denizmaral/hunspell.git', :tag => s.version.to_s }
  s.platform     = :ios, '13.0'
  s.source_files = 'Hunspell/**/*.{h,m,swift,c,cpp}'
  s.requires_arc = true
end
