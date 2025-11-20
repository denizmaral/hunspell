Pod::Spec.new do |s|
  s.name         = 'Hunspell'
  s.version      = '1.0.0'
  s.summary      = 'Hunspell spell checker library for iOS'
  s.description  = 'Hunspell is a spell checker and morphological analyzer library and program designed for languages with rich morphology and complex word compounding or character encoding.'
  s.homepage     = 'https://github.com/denizmaral/hunspell'
  s.license      = { :type => 'LGPL-2.1', :file => 'COPYING.LGPL' }
  s.author       = { 'Deniz Maral' => 'dnzmaral@gmail.com' }
  s.source       = { :git => 'https://github.com/denizmaral/hunspell.git', :tag => "v#{s.version}" }
  
  s.platform     = :ios, '13.0'
  s.ios.deployment_target = '13.0'
  
  # Point to the actual Hunspell source files
  s.source_files = 'src/hunspell/*.{cxx,hxx,h}'
  
  # Public headers
  s.public_header_files = 'src/hunspell/hunspell.hxx', 'src/hunspell/hunspell.h'
  
  # Compiler flags for C++
  s.xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
    'CLANG_CXX_LIBRARY' => 'libc++'
  }
  
  s.requires_arc = false
  s.libraries = 'c++'
end
