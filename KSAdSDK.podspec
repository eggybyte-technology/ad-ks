Pod::Spec.new do |s|
  s.name = "EBKSAdSDK"
  s.version = "1.0.0"
  s.summary = "EggyByte Ad SDK - EBKSAdSDK Integration"
  s.description = "EggyByte Ad SDK provides comprehensive advertising solutions with KSAdSDK integration for iOS applications, rebranded as EBKSAdSDK."
  s.authors = {"EggyByte Technology 2025"=>"affair@eggybyte.com"}
  s.homepage = "https://example.com/"
  s.frameworks = ["Foundation", "UIKit", "MobileCoreServices", "CoreGraphics", "Security", "SystemConfiguration", "CoreTelephony", "AdSupport", "CoreData", "StoreKit", "AVFoundation", "MediaPlayer", "CoreMedia", "WebKit", "Accelerate", "CoreLocation", "AVKit", "MessageUI", "QuickLook", "AudioToolBox", "JavaScriptCore", "CoreMotion", "Photos"]
  s.libraries = ["z", "resolv.9", "sqlite3", "c++", "c++abi"]
  s.source = { :http=>"https://p4-ad.adukwai.com/udata/pkg/KSAdSDKTarGz/KSAdSDK-framework-content-1.0.0-140.tar.gz" }
  s.license = { :type => "MIT", :text => <<-LICENSE
    MIT License

    Copyright (c) 2024 EggyByte Technology 2025

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE. 
    LICENSE
  }

  s.ios.deployment_target = '12.0'
  
  # XCFramework configuration
  s.ios.vendored_frameworks = 'KSAdSDK.xcframework'
  
  # Module configuration for Swift import
  s.module_name = 'EBKSAdSDK'
  s.swift_version = '5.0'
  
  # Header files configuration
  s.public_header_files = ['EBKSAdSDK-umbrella.h', 'KSAdSDK.xcframework/*/KSAdSDK.framework/Headers/*.h']
  s.source_files = ['EBKSAdSDK-umbrella.h', 'KSAdSDK.xcframework/*/KSAdSDK.framework/Headers/*.h']
  
  # Module map configuration for proper Swift interop
  s.preserve_paths = ['KSAdSDK.xcframework', 'module.modulemap', 'EBKSAdSDK-umbrella.h']
  s.module_map = 'module.modulemap'
  
  # Pod configuration
  s.requires_arc = true
  s.static_framework = true
  
  # Additional compiler flags
  s.pod_target_xcconfig = {
    'VALID_ARCHS' => 'arm64 armv7 x86_64',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited)',
    'OTHER_LDFLAGS' => '-framework KSAdSDK',
    'SWIFT_INCLUDE_PATHS' => '$(SRCROOT)/EBKSAdSDK/1.0.0'
  }
  
  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'
  }
end
