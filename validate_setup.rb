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
    { pattern: /s\.module_map\s*=\s*["']module\.modulemap["']/, desc: "Module map is configured" }
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
end

def validate_umbrella_header(path)
  content = File.read(path)
  
  important_imports = [
    '#import <KSAdSDK/KSAdSDK.h>',
    '#import <KSAdSDK/KSCUFeedPage.h>',
    '#import <KSAdSDK/KSCUContentPage.h>',
    '#import <KSAdSDK/KSBannerAd.h>',
    '#import <KSAdSDK/KSRewardedVideoAd.h>'
  ]
  
  important_imports.each do |import|
    if content.include?(import)
      puts "✅ Umbrella header includes: #{import}"
    else
      puts "❌ Umbrella header missing: #{import}"
    end
  end
end

puts "🔍 Validating EBKSAdSDK Setup..."
puts "=" * 50

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
puts "-" * 30

if File.exist?('EBKSAdSDK.podspec')
  puts "\n🔧 Podspec Validation:"
  validate_podspec('EBKSAdSDK.podspec')
end

if File.exist?('module.modulemap')
  puts "\n🗺️  Module Map Validation:"
  validate_module_map('module.modulemap')
end

if File.exist?('EBKSAdSDK-umbrella.h')
  puts "\n📄 Umbrella Header Validation:"
  validate_umbrella_header('EBKSAdSDK-umbrella.h')
end

puts "\n" + "=" * 50

if all_files_exist && all_dirs_exist
  puts "🎉 EBKSAdSDK setup validation completed!"
  puts "\n📱 Ready for local development!"
  puts "\nNext steps:"
  puts "1. Add to your Podfile: pod 'EBKSAdSDK', :path => './path/to/EBKSAdSDK/1.0.0'"
  puts "2. Run: pod install"
  puts "3. Import in Swift: import EBKSAdSDK"
else
  puts "⚠️  Setup validation found issues. Please fix the missing files/directories."
end 