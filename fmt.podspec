Pod::Spec.new do |spec|
  spec.name         = 'fmt'
  spec.version      = '6.2.1-patched'
  spec.summary      = '{fmt} is a safe and fast formatting library for C++'
  spec.homepage     = 'https://github.com/sufyansalim/fmt'
  spec.license      = { :type => 'MIT' }
  spec.authors      = { 'Victor Zverovich' => 'zverovich@google.com' }

  # make sure CocoaPods reads *this* spec
  spec.source       = {
    :git => 'https://github.com/sufyansalim/fmt.git',
    :branch => 'disable-char8t-overloads'
  }

  spec.platforms    = { :ios => '10.0', :osx => '10.14' }

  # include everything except the offending format.cc
  spec.source_files  = ['src/*.cc', 'include/**/*.{hpp,h}']
  spec.exclude_files = ['src/format.cc', 'src/os.cc']

  spec.public_header_files = 'include/**/*.{hpp,h}'
  spec.preserve_paths       = 'include'

  # build under C++17 + libc++ and disable the char8_t overloads
  spec.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
    'CLANG_CXX_LIBRARY'            => 'libc++',
    'OTHER_CPLUSPLUSFLAGS'         => '$(inherited) -DFMT_USE_CHAR8_T=0'
  }
end
