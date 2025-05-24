Pod::Spec.new do |s|
  s.name = "EBKSAdSDK"
  s.version = "v1.0.0"
  s.summary = "EggyByte Ad SDK - EBKSAdSDK Integration"
  s.description = "EggyByte Ad SDK provides comprehensive advertising solutions with KSAdSDK integration for iOS applications, rebranded as EBKSAdSDK."
  s.authors = {"EggyByte Technology 2025"=>"affair@eggybyte.com"}
  s.homepage = "https://github.com/eggybyte-technology/ad-ks.git"
  s.frameworks = ["Foundation", "UIKit", "MobileCoreServices", "CoreGraphics", "Security", "SystemConfiguration", "CoreTelephony", "AdSupport", "CoreData", "StoreKit", "AVFoundation", "MediaPlayer", "CoreMedia", "WebKit", "Accelerate", "CoreLocation", "AVKit", "MessageUI", "QuickLook", "AudioToolBox", "JavaScriptCore", "CoreMotion", "Photos"]
  s.libraries = ["z", "resolv.9", "sqlite3", "c++", "c++abi"]
  s.source = { 
    :git => "https://github.com/eggybyte-technology/ad-ks.git", 
    :tag => s.version.to_s 
  }
  s.license = { :type => "MIT", :file => "LICENSE" }

  s.ios.deployment_target = '12.0'
  
  # XCFramework configuration
  s.ios.vendored_frameworks = 'KSAdSDK.xcframework'
  
  # Module configuration for Swift import
  s.module_name = 'EBKSAdSDK'
  s.swift_version = '5.0'
  
  # Header files configuration for local development
  s.public_header_files = 'EBKSAdSDK-umbrella.h'
  s.source_files = 'EBKSAdSDK-umbrella.h'
  
  # Module map configuration for proper Swift interop
  s.preserve_paths = ['KSAdSDK.xcframework/**/*', 'module.modulemap', 'EBKSAdSDK-umbrella.h']
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
    'SWIFT_INCLUDE_PATHS' => '${PODS_ROOT}/EBKSAdSDK',
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
  }
  
  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'
  }
end
