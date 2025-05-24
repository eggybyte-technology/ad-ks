# EggyByte Ad SDK - EBKSAdSDK Integration

## Overview

This podspec provides a Swift-friendly integration of KSAdSDK under the EggyByte brand, rebranded as **EBKSAdSDK**. The SDK has been configured to support modern Swift import syntax and module naming conventions, with comprehensive header exposure including all Content Union (KSCU) and E-commerce Union (KSEU) components.

## Features

- ✅ Swift 5.0+ compatibility
- ✅ XCFramework support
- ✅ Custom module naming (`EBKSAdSDK`)
- ✅ Comprehensive header exposure for Swift interop
- ✅ Complete Content Union (KSCU) API support
- ✅ E-commerce Union (KSEU) integration
- ✅ Modern iOS deployment target (iOS 12.0+)
- ✅ All ad formats: Banner, Splash, Interstitial, Rewarded Video, Native, Feed, Draw
- ✅ Server-side bidding support
- ✅ Local development support

## Installation

### Option 1: Local Pod (Recommended for development)

Add the following to your `Podfile`:

```ruby
pod 'EBKSAdSDK', :path => './path/to/EBKSAdSDK/1.0.0'
```

### Option 2: Git Repository

Add the following to your `Podfile`:

```ruby
pod 'EBKSAdSDK', :git => 'https://github.com/EggyByte/EBKSAdSDK.git', :tag => '1.0.0'
```

### Option 3: Version-based (if published)

```ruby
pod 'EBKSAdSDK', '1.0.0'
```

Then run:

```bash
pod install
```

## Usage in Swift

### Import the SDK

```swift
import EBKSAdSDK
```

### Basic Integration Example

```swift
import UIKit
import EBKSAdSDK

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the SDK
        let config = KSAdSDKConfiguration.configuration()
        config.appId = "your-app-id"
        
        KSAdSDKManager.start { success, error in
            if success {
                print("EBKSAdSDK initialized successfully")
            } else {
                print("EBKSAdSDK initialization failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
```

### Content Union Integration

```swift
import EBKSAdSDK

class ContentViewController: UIViewController {
    
    func setupContentFeed() {
        // Create content feed page
        let feedPage = KSCUFeedPage(posId: "your-content-pos-id")
        feedPage.hidesBottomBarWhenPushed = true
        
        // Add to your navigation stack
        navigationController?.pushViewController(feedPage.feedViewController, animated: true)
    }
    
    func setupHotspotPage() {
        // Create hotspot page with configuration
        let hotspotPage = KSCUHotspotPage(posId: "your-hotspot-pos-id") { config in
            config.videoStateDelegate = self
            config.stateDelegate = self
        }
        
        present(hotspotPage.hotspotViewController, animated: true)
    }
}
```

### Ad Integration Examples

```swift
// Banner Ad
let bannerAd = KSBannerAd(posId: "your-banner-pos-id")
bannerAd.delegate = self
bannerAd.loadAdData()

// Splash Ad
let splashAd = KSSplashAdView(posId: "your-splash-pos-id")
splashAd.delegate = self
splashAd.rootViewController = self
splashAd.loadAdData()

// Rewarded Video Ad
let rewardModel = KSRewardedVideoModel()
rewardModel.userId = "user123"
rewardModel.amount = 100

let rewardedAd = KSRewardedVideoAd(posId: "your-reward-pos-id", rewardedVideoModel: rewardModel)
rewardedAd.delegate = self
rewardedAd.loadAdData()
```

### Usage in Objective-C

If you need to use it in Objective-C files, you can still import it using:

```objc
#import <KSAdSDK/KSAdSDK.h>
```

## Module Structure

The SDK is configured with the following structure:

- **Module Name**: `EBKSAdSDK`
- **Framework**: `KSAdSDK.xcframework`
- **Headers**: Comprehensive header exposure including all KSCU and KSEU components
- **Swift Import**: `import EBKSAdSDK`

## Comprehensive API Coverage

### Core Ad Types
- **Banner Ads**: `KSBannerAd`
- **Splash Ads**: `KSSplashAdView`
- **Interstitial Ads**: `KSInterstitialAd`
- **Rewarded Video**: `KSRewardedVideoAd`
- **Fullscreen Video**: `KSFullscreenVideoAd`
- **Native Ads**: `KSNativeAd`, `KSNativeAdsManager`
- **Feed Ads**: `KSFeedAd`, `KSFeedAdsManager`
- **Draw Ads**: `KSDrawAd`, `KSDrawAdsManager`

### Content Union (KSCU) Features
- **Content Pages**: `KSCUContentPage`
- **Feed Pages**: `KSCUFeedPage`
- **Entry Elements**: `KSCUEntryElement`
- **Horizontal Feed**: `KSCUHorizontalFeed`
- **Hotspot Pages**: `KSCUHotspotPage`
- **Tube Pages**: `KSCUTubePage`
- **Embedded Ad Config**: `KSCUEmbedAdConfig`

### E-commerce Union (KSEU)
- **Extra Info**: `KSEUExtraInfo`
- **Live Shopping**: `KSAdLiveInfoData`, `KSAdLiveShopData`
- **Coupon Support**: `KSAdCouponData`

### Server-Side Bidding
- **Bidding Models**: `KSAdBiddingAdModel`
- **Exposure Reporting**: `KSAdExposureReportParam`
- **Response Handling**: V1 and V2 APIs supported

## Files Included

- `EBKSAdSDK.podspec` - Pod specification with Swift integration and local development support
- `module.modulemap` - Module map for proper Swift interop
- `EBKSAdSDK-umbrella.h` - Comprehensive umbrella header exposing all SDK functionality
- `KSAdSDK.xcframework` - The actual framework (includes all architectures)
- `ExampleUsage.swift` - Comprehensive Swift usage examples
- `Example-Podfile` - Example Podfile configuration

## Technical Details

### Supported Architectures
- ARM64 (device)
- ARMv7 (older devices)
- x86_64 (simulator)

### Dependencies
The SDK links against the following system frameworks:
- Foundation, UIKit, CoreGraphics
- AdSupport, AVFoundation, CoreLocation
- WebKit, StoreKit, SystemConfiguration
- CoreData, MediaPlayer, CoreMedia
- Accelerate, AVKit, MessageUI, QuickLook
- AudioToolBox, JavaScriptCore, CoreMotion, Photos

### Build Configuration

The podspec includes optimized build settings for:
- Local development support
- Static framework configuration
- Proper architecture exclusions for simulator
- Framework search paths
- Swift module include paths
- Non-modular includes support

## Local Development Setup

1. **Clone or download the EBKSAdSDK repository**
2. **Add to your Podfile with local path**:
   ```ruby
   pod 'EBKSAdSDK', :path => './path/to/EBKSAdSDK/1.0.0'
   ```
3. **Run pod install**
4. **Import in your Swift files**:
   ```swift
   import EBKSAdSDK
   ```

## Migration from KSAdSDK

If you're migrating from the original KSAdSDK:

1. **Update Podfile**: Change `pod 'KSAdSDK'` to `pod 'EBKSAdSDK'`
2. **Update Imports**: Change `import KSAdSDK` to `import EBKSAdSDK`
3. **Rebuild**: Clean and rebuild your project

The API remains the same, only the module name changes.

## Troubleshooting

### Common Issues

1. **"Module not found" error**
   - Ensure you're using `import EBKSAdSDK` (not `import KSAdSDK`)
   - Clean and rebuild your project
   - Check that the path in your Podfile is correct

2. **Missing Content Union APIs**
   - All KSCU APIs are now properly exposed through the umbrella header
   - Check that you're using the correct class names (e.g., `KSCUFeedPage`)

3. **Simulator build issues**
   - The podspec excludes i386 architecture for simulators (modern requirement)
   - Use ARM64 simulator if available

4. **Header not found**
   - The comprehensive umbrella header should automatically expose all SDK headers
   - All KSCU, KSEU, and core ad components are included

5. **Local development issues**
   - Ensure the path in your Podfile points to the correct directory
   - Make sure all files (especially `module.modulemap` and `EBKSAdSDK-umbrella.h`) are present

### Support

For issues related to this integration, contact EggyByte Technology 2025 at affair@eggybyte.com

## License

MIT License - See the podspec file for full license text.