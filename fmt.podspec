# fmt.podspec — for fmt 6.2.1 with char8_t overloads disabled

Pod::Spec.new do |spec|
  spec.name         = 'fmt'
  spec.version      = '6.2.1'
  spec.summary      = '{fmt} is a safe and fast formatting library for C++'
  spec.homepage     = 'https://github.com/sufyansalim/fmt'
  spec.license      = { :type => 'MIT' }
  spec.authors      = { 'Victor Zverovich' => 'zverovich@google.com' }

  # point at *your* fork & tag
  spec.source       = {
    :git => 'https://github.com/sufyansalim/fmt.git',
    :tag => '6.2.1'
  }

  spec.platforms    = { :ios => '10.0', :osx => '10.14' }

  # ----------------------------------------------------------------------------
  # Include everything under src/ and include/, then strip out format.cc
  # ----------------------------------------------------------------------------
  spec.source_files = [
    'src/*.cc',
    'include/**/*.{hpp,h}'
  ]
  spec.exclude_files = [
    'src/os.cc',      # upstream excludes this anyway
    'src/format.cc'   # we drop the one that trips char8_t
  ]

  spec.public_header_files = 'include/**/*.{hpp,h}'
  spec.preserve_paths      = 'include'

  # ----------------------------------------------------------------------------
  # Build flags: C++17 + libc++, and disable fmt's char8_t overloads
  # ----------------------------------------------------------------------------
  spec.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
    'CLANG_CXX_LIBRARY'            => 'libc++',
    'OTHER_CPLUSPLUSFLAGS'         => '$(inherited) -DFMT_USE_CHAR8_T=0'
  }
end
