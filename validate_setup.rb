#!/usr/bin/env ruby

# validate_setup.rb
# Validation script for EBKSAdSDK local development setup

require 'fileutils'

def check_file_exists(path, description)
  if File.exist?(path)
    puts "✅ #{description}: #{path}"
    true
  else
    puts "❌ #{description} missing: #{path}"
    false
  end
end

def check_directory_exists(path, description)
  if Dir.exist?(path)
    puts "✅ #{description}: #{path}"
    true
  else
    puts "❌ #{description} missing: #{path}"
    false
  end
end

def validate_podspec(path)
  content = File.read(path)
  
  checks = [
    { pattern: /s\.name\s*=\s*["']EBKSAdSDK["']/, desc: "Pod name is EBKSAdSDK" },
    { pattern: /s\.module_name\s*=\s*["']EBKSAdSDK["']/, desc: "Module name is EBKSAdSDK" },
    { pattern: /s\.source\s*=.*:git/, desc: "Source is configured for git" },
    { pattern: /s\.ios\.vendored_frameworks\s*=.*KSAdSDK\.xcframework/, desc: "XCFramework is configured" },
    { pattern: /s\.module_map\s*=\s*["']module\.modulemap["']/, desc: "Module map is configured" },
    { pattern: /s\.source_files\s*=.*umbrella\.h/, desc: "Umbrella header is configured as source file" },
    { pattern: /DEFINES_MODULE.*YES/, desc: "Module definition is enabled" }
  ]
  
  checks.each do |check|
    if content.match(check[:pattern])
      puts "✅ #{check[:desc]}"
    else
      puts "❌ #{check[:desc]}"
    end
  end
end

def validate_module_map(path)
  content = File.read(path)
  
  if content.include?('framework module EBKSAdSDK')
    puts "✅ Module map defines EBKSAdSDK framework"
  else
    puts "❌ Module map doesn't define EBKSAdSDK framework"
  end
  
  if content.include?('umbrella header "EBKSAdSDK-umbrella.h"')
    puts "✅ Module map references correct umbrella header"
  else
    puts "❌ Module map doesn't reference EBKSAdSDK-umbrella.h"
  end
  
  if content.include?('link framework "KSAdSDK"')
    puts "✅ Module map links KSAdSDK framework"
  else
    puts "❌ Module map doesn't link KSAdSDK framework"
  end
end

def validate_umbrella_header(path)
  content = File.read(path)
  
  # Core headers that should be included
  essential_imports = [
    '#import <KSAdSDK/KSAdSDK.h>',
    '#import <KSAdSDK/KSAdSDKManager.h>',
    '#import <KSAdSDK/KSAdSDKConfiguration.h>',
    '#import <KSAdSDK/KSBannerAd.h>',
    '#import <KSAdSDK/KSRewardedVideoAd.h>',
    '#import <KSAdSDK/KSNativeAd.h>',
    '#import <KSAdSDK/KSSplashAdView.h>',
    '#import <KSAdSDK/KSInterstitialAd.h>'
  ]
  
  # Content Union headers
  content_union_imports = [
    '#import <KSAdSDK/KSCUFeedPage.h>',
    '#import <KSAdSDK/KSCUContentPage.h>',
    '#import <KSAdSDK/KSCUHotspotPage.h>',
    '#import <KSAdSDK/KSCUSDKManager.h>'
  ]
  
  # Advanced features
  advanced_imports = [
    '#import <KSAdSDK/KSAdBiddingAdModel.h>',
    '#import <KSAdSDK/KSEUExtraInfo.h>',
    '#import <KSAdSDK/KSAdPlayableDemoViewController.h>'
  ]
  
  puts "\n  📋 Essential SDK Headers:"
  essential_count = 0
  essential_imports.each do |import|
    if content.include?(import)
      puts "  ✅ #{import}"
      essential_count += 1
    else
      puts "  ❌ Missing: #{import}"
    end
  end
  
  puts "\n  🎮 Content Union Headers:"
  content_count = 0
  content_union_imports.each do |import|
    if content.include?(import)
      puts "  ✅ #{import}"
      content_count += 1
    else
      puts "  ❌ Missing: #{import}"
    end
  end
  
  puts "\n  🚀 Advanced Feature Headers:"
  advanced_count = 0
  advanced_imports.each do |import|
    if content.include?(import)
      puts "  ✅ #{import}"
      advanced_count += 1
    else
      puts "  ❌ Missing: #{import}"
    end
  end
  
  total_expected = essential_imports.length + content_union_imports.length + advanced_imports.length
  total_found = essential_count + content_count + advanced_count
  
  puts "\n  📊 Coverage: #{total_found}/#{total_expected} headers (#{((total_found.to_f / total_expected) * 100).round(1)}%)"
  
  if total_found == total_expected
    puts "  🎉 All expected headers are included!"
  elsif total_found >= essential_imports.length
    puts "  ⚠️  Essential headers are present, but some optional headers are missing"
  else
    puts "  ❌ Critical headers are missing!"
  end
end

def validate_xcframework_headers
  framework_path = "KSAdSDK.xcframework/ios-arm64_armv7/KSAdSDK.framework/Headers"
  
  if Dir.exist?(framework_path)
    headers = Dir.glob("#{framework_path}/*.h").map { |f| File.basename(f) }
    puts "✅ Found #{headers.length} header files in KSAdSDK framework"
    
    # Show some key headers
    key_headers = headers.select { |h| 
      h.include?('KSAdSDK') || h.include?('KSCU') || h.include?('Banner') || h.include?('Native')
    }
    
    if key_headers.length > 0
      puts "  Key headers found: #{key_headers[0..4].join(', ')}#{key_headers.length > 5 ? '...' : ''}"
    end
  else
    puts "❌ KSAdSDK framework headers directory not found"
  end
end

puts "🔍 Validating EBKSAdSDK Complete Setup..."
puts "=" * 60

# Check required files
required_files = [
  ['EBKSAdSDK.podspec', 'Podspec file'],
  ['module.modulemap', 'Module map file'],
  ['EBKSAdSDK-umbrella.h', 'Umbrella header file'],
  ['README.md', 'README documentation'],
  ['ExampleUsage.swift', 'Swift example file'],
  ['Example-Podfile', 'Example Podfile']
]

all_files_exist = true
required_files.each do |file, desc|
  all_files_exist &= check_file_exists(file, desc)
end

# Check required directories
required_dirs = [
  ['KSAdSDK.xcframework', 'XCFramework directory']
]

all_dirs_exist = true
required_dirs.each do |dir, desc|
  all_dirs_exist &= check_directory_exists(dir, desc)
end

puts "\n📋 Validating Configuration Files..."
puts "-" * 40

if File.exist?('EBKSAdSDK.podspec')
  puts "\n🔧 Podspec Validation:"
  validate_podspec('EBKSAdSDK.podspec')
end

if File.exist?('module.modulemap')
  puts "\n🗺️  Module Map Validation:"
  validate_module_map('module.modulemap')
end

puts "\n📦 XCFramework Headers:"
validate_xcframework_headers

if File.exist?('EBKSAdSDK-umbrella.h')
  puts "\n📄 Umbrella Header Validation:"
  validate_umbrella_header('EBKSAdSDK-umbrella.h')
end

puts "\n" + "=" * 60

if all_files_exist && all_dirs_exist
  puts "🎉 EBKSAdSDK complete setup validation finished!"
  puts "\n📱 Ready for Swift import with: import EBKSAdSDK"
  puts "\nNext steps:"
  puts "1. Add to your Podfile: pod 'EBKSAdSDK', :path => './path/to/ad-ks'"
  puts "2. Run: pod install"
  puts "3. Import in Swift: import EBKSAdSDK"
  puts "4. All KSAdSDK classes will be available through the EBKSAdSDK module"
else
  puts "⚠️  Setup validation found issues. Please fix the missing files/directories."
end 