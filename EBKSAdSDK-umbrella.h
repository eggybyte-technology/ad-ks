//
//  EBKSAdSDK-umbrella.h
//  EggyByte Ad SDK - EBKSAdSDK Integration
//
//  Copyright (c) 2024 EggyByte Technology 2025. All rights reserved.
//

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

//! Project version number for EBKSAdSDK.
FOUNDATION_EXPORT double EBKSAdSDKVersionNumber;

//! Project version string for EBKSAdSDK.
FOUNDATION_EXPORT const unsigned char EBKSAdSDKVersionString[];

// Core SDK Headers
#import <KSAdSDK/KSAdSDK.h>
#import <KSAdSDK/KSAdSDKManager.h>
#import <KSAdSDK/KSAdSDKConfiguration.h>
#import <KSAdSDK/KSAdSDKError.h>
#import <KSAdSDK/KSAdSDKLogLevelDefine.h>

// Base Ad Classes
#import <KSAdSDK/KSAd.h>
#import <KSAdSDK/KSVideoAd.h>
#import <KSAdSDK/KSMaterialMeta.h>
#import <KSAdSDK/KSAdImage.h>
#import <KSAdSDK/KSAdUserInfo.h>
#import <KSAdSDK/KSAdInteractionType.h>
#import <KSAdSDK/KSAdShowDirection.h>
#import <KSAdSDK/KSAdDeviceInfoEnum.h>
#import <KSAdSDK/KSAdExportManager.h>
#import <KSAdSDK/KSAdPermission.h>

// Ad Types
#import <KSAdSDK/KSBannerAd.h>
#import <KSAdSDK/KSSplashAdView.h>
#import <KSAdSDK/KSInterstitialAd.h>
#import <KSAdSDK/KSRewardedVideoAd.h>
#import <KSAdSDK/KSFullscreenVideoAd.h>
#import <KSAdSDK/KSNativeAd.h>
#import <KSAdSDK/KSFeedAd.h>
#import <KSAdSDK/KSDrawAd.h>

// Ad Managers
#import <KSAdSDK/KSNativeAdsManager.h>
#import <KSAdSDK/KSFeedAdsManager.h>
#import <KSAdSDK/KSDrawAdsManager.h>

// Ad Models and Support Classes
#import <KSAdSDK/KSRewardedVideoModel.h>
#import <KSAdSDK/KSRewardedVideoAdDefines.h>
#import <KSAdSDK/KSVideoAdView.h>
#import <KSAdSDK/KSNativeAdRelatedView.h>
#import <KSAdSDK/KSNativeAdRotateView.h>
#import <KSAdSDK/KSAdViewActionConfiguration.h>
#import <KSAdSDK/KSInnerVideoAd.h>

// Bidding Support
#import <KSAdSDK/KSAdBiddingAdModel.h>
#import <KSAdSDK/KSAdExposureReportParam.h>
#import <KSAdSDK/KSAdExtraDataModel.h>
#import <KSAdSDK/KSAdNativeAdExtraDataModel.h>
#import <KSAdSDK/KSAdSplashAdExtraDataModel.h>
#import <KSAdSDK/KSAdNativeAdStatusInfo.h>
#import <KSAdSDK/KSAdNativeStyleControl.h>

// Playable Ad Support
#import <KSAdSDK/KSAdPlayableDemoViewController.h>

// Live Ad Support
#import <KSAdSDK/KSAdInfoData.h>
#import <KSAdSDK/KSAdLiveInfoData.h>
#import <KSAdSDK/KSAdLiveBaseData.h>
#import <KSAdSDK/KSAdLiveShopData.h>
#import <KSAdSDK/KSAdCouponData.h>

// Content Union (KSC) Headers - These were missing from original KSAdSDK.h
#import <KSAdSDK/KSCUContentPage.h>
#import <KSAdSDK/KSCUFeedPage.h>
#import <KSAdSDK/KSCUEntryElement.h>
#import <KSAdSDK/KSCUHorizontalFeed.h>
#import <KSAdSDK/KSCUHotspotPage.h>
#import <KSAdSDK/KSCUTubePage.h>
#import <KSAdSDK/KSCUSDKManager.h>
#import <KSAdSDK/KSCUOuterController.h>

// Content Union Protocols and Delegates
#import <KSAdSDK/KSCUContentPageDelegate.h>
#import <KSAdSDK/KSCUCallBackProtocol.h>
#import <KSAdSDK/KSCUEmbedAdConfig.h>
#import <KSAdSDK/KSCUFeedEvent.h>
#import <KSAdSDK/KSCUFeedPageScrollViewDelegate.h>
#import <KSAdSDK/KSCUHorizontalFeedCallBackProtocol.h>
#import <KSAdSDK/KSCUHotspotDataProtocol.h>
#import <KSAdSDK/KSCUTubeColorConfig.h>

// E-commerce Union Support
#import <KSAdSDK/KSEUExtraInfo.h> 