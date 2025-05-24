//
//  ExampleUsage.swift
//  EBKSAdSDK Example
//
//  This file demonstrates how to use EBKSAdSDK in your iOS application
//  Copyright (c) 2024 EggyByte Technology 2025. All rights reserved.
//

import UIKit
import EBKSAdSDK

// MARK: - SDK Initialization
class EBKSAdSDKManager {
    
    static let shared = EBKSAdSDKManager()
    
    private init() {}
    
    func initializeSDK(appId: String) {
        let config = KSAdSDKConfiguration.configuration()
        config.appId = appId
        config.setLoglevel(.debug) // Use .off for production
        
        // Optional configurations
        config.setUserAge(.belowThirty, gender: .female, interest: "gaming,shopping")
        config.setContentPrevTitle("Previous Article", 
                                   postTitle: "Next Article", 
                                   historyTitle: "Recently Read", 
                                   channel: "entertainment")
        
        KSAdSDKManager.start { success, error in
            if success {
                print("✅ EBKSAdSDK initialized successfully")
            } else {
                print("❌ EBKSAdSDK initialization failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}

// MARK: - Banner Ad Example
class BannerAdViewController: UIViewController {
    
    private var bannerAd: KSBannerAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBannerAd()
    }
    
    private func setupBannerAd() {
        bannerAd = KSBannerAd(posId: "your-banner-pos-id")
        bannerAd?.delegate = self
        bannerAd?.loadAdData()
    }
}

extension BannerAdViewController: KSBannerAdDelegate {
    func ksad_bannerAdViewDidLoad(_ bannerAdView: KSBannerAd) {
        print("Banner ad loaded")
    }
    
    func ksad_bannerAdViewRenderSuccess(_ bannerAd: KSBannerAd) {
        print("Banner ad render success")
        bannerAd.showFromViewController(self)
    }
    
    func ksad_bannerAdView(_ bannerAdView: KSBannerAd, didFailWithError error: Error?) {
        print("Banner ad failed: \(error?.localizedDescription ?? "Unknown error")")
    }
}

// MARK: - Content Union Integration
class ContentFeedViewController: UIViewController {
    
    private var feedPage: KSCUFeedPage?
    private var hotspotPage: KSCUHotspotPage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentFeed()
        setupHotspotPage()
    }
    
    private func setupContentFeed() {
        feedPage = KSCUFeedPage(posId: "your-content-pos-id", promoteID: nil, comment: nil)
        feedPage?.hidesBottomBarWhenPushed = true
        feedPage?.videoStateDelegate = self
        feedPage?.stateDelegate = self
        feedPage?.callBackDelegate = self
    }
    
    private func setupHotspotPage() {
        hotspotPage = KSCUHotspotPage(posId: "your-hotspot-pos-id") { config in
            config.videoStateDelegate = self
            config.stateDelegate = self
            config.callBackDelegate = self
        }
    }
    
    @IBAction func showContentFeed(_ sender: UIButton) {
        guard let feedVC = feedPage?.feedViewController else { return }
        navigationController?.pushViewController(feedVC, animated: true)
    }
    
    @IBAction func showHotspotPage(_ sender: UIButton) {
        guard let hotspotVC = hotspotPage?.hotspotViewController else { return }
        present(hotspotVC, animated: true)
    }
}

// MARK: - Content Union Delegates
extension ContentFeedViewController: KSCUVideoStateDelegate, KSCUContentStateDelegate, KSCUFeedPageCallBackProtocol {
    
    func kscu_videoDidStartPlay(_ videoContent: KSCUContentInfo) {
        print("Video started: \(videoContent.publicContentId)")
    }
    
    func kscu_contentDidFullDisplay(_ content: KSCUContentInfo) {
        print("Content displayed: \(content.publicContentId)")
    }
    
    func kscuContentRequestSuccess(_ event: KSCUFeedEvent, callBack responseObj: KSCUResponseObj) {
        print("Content request success with \(responseObj.countOfVideoInRequest) videos")
    }
}

// MARK: - Rewarded Video Ad Example
class RewardedVideoViewController: UIViewController {
    
    private var rewardedVideoAd: KSRewardedVideoAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRewardedVideoAd()
    }
    
    private func setupRewardedVideoAd() {
        let rewardModel = KSRewardedVideoModel()
        rewardModel.userId = "user123"
        rewardModel.name = "Gold Coins"
        rewardModel.amount = 100
        rewardModel.extra = "level_completion"
        
        rewardedVideoAd = KSRewardedVideoAd(posId: "your-rewarded-pos-id", rewardedVideoModel: rewardModel)
        rewardedVideoAd?.delegate = self
        rewardedVideoAd?.loadAdData()
    }
    
    @IBAction func showRewardedVideo(_ sender: UIButton) {
        guard let ad = rewardedVideoAd, ad.isValid else {
            print("Rewarded video not ready")
            return
        }
        
        _ = ad.showAdFromRootViewController(self)
    }
}

extension RewardedVideoViewController: KSRewardedVideoAdDelegate {
    func rewardedVideoAdDidLoad(_ rewardedVideoAd: KSRewardedVideoAd) {
        print("Rewarded video loaded")
    }
    
    func rewardedVideoAd(_ rewardedVideoAd: KSRewardedVideoAd, hasReward: Bool) {
        if hasReward {
            print("User earned reward!")
            // Grant reward to user
        }
    }
    
    func rewardedVideoAd(_ rewardedVideoAd: KSRewardedVideoAd, didFailWithError error: Error?) {
        print("Rewarded video failed: \(error?.localizedDescription ?? "Unknown error")")
    }
}

// MARK: - Native Ad Example
class NativeAdViewController: UIViewController {
    
    @IBOutlet weak var adContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    
    private var nativeAdsManager: KSNativeAdsManager?
    private var nativeAd: KSNativeAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNativeAd()
    }
    
    private func setupNativeAd() {
        nativeAdsManager = KSNativeAdsManager(posId: "your-native-pos-id")
        nativeAdsManager?.delegate = self
        nativeAdsManager?.loadAdData(withCount: 1)
    }
    
    private func renderNativeAd(_ ad: KSNativeAd) {
        guard let data = ad.data else { return }
        
        titleLabel.text = data.productName
        descriptionLabel.text = data.adDescription
        actionButton.setTitle(data.actionDescription, for: .normal)
        
        // Load app icon image
        if let iconImage = data.appIconImage {
            // Load image from iconImage.imageURL
        }
        
        // Register views for interaction
        let configuration = KSAdViewActionConfiguration()
        configuration.isClickable = true
        configuration.isSlidable = true
        
        ad.registerContainer(adContainerView, withViewActionConfiguration: configuration)
        ad.registerActionViews([actionButton], withViewActionConfiguration: configuration)
    }
}

extension NativeAdViewController: KSNativeAdsManagerDelegate {
    func nativeAdsManagerSuccessToLoad(_ adsManager: KSNativeAdsManager, nativeAds: [KSNativeAd]?) {
        guard let ads = nativeAds, let firstAd = ads.first else { return }
        
        nativeAd = firstAd
        firstAd.rootViewController = self
        firstAd.delegate = self
        
        renderNativeAd(firstAd)
    }
    
    func nativeAdsManager(_ adsManager: KSNativeAdsManager, didFailWithError error: Error?) {
        print("Native ads failed to load: \(error?.localizedDescription ?? "Unknown error")")
    }
}

extension NativeAdViewController: KSNativeAdDelegate {
    func nativeAdDidShow(_ nativeAd: KSNativeAd) {
        print("Native ad shown")
    }
    
    func nativeAdDidClick(_ nativeAd: KSNativeAd, withView view: UIView?) {
        print("Native ad clicked")
    }
}

// MARK: - Server-Side Bidding Example
class ServerBiddingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demonstrateBidding()
    }
    
    private func demonstrateBidding() {
        // Create bidding model
        let biddingModel = KSAdBiddingAdModel()
        biddingModel.posId = "your-pos-id"
        biddingModel.adCount = 1
        biddingModel.direction = .vertical
        biddingModel.cpmBidFloor = 100 // 100 cents = $1.00
        
        // Get bid request token
        let token = KSAdSDKManager.getBidRequestToken(biddingModel)
        print("Bid request token: \(token)")
        
        // In a real implementation, you would:
        // 1. Send this token to your server
        // 2. Your server conducts the auction
        // 3. Server returns winning response
        // 4. Use the response to load the ad
        
        // Example response handling:
        let mockResponse: [String: Any] = [
            "ad_id": "12345",
            "ecpm": 150,
            "creative_data": "..."
        ]
        
        // Load ad with response
        let bannerAd = KSBannerAd(posId: biddingModel.posId)
        bannerAd.loadAdDataWithResponseV2(mockResponse)
    }
}

// MARK: - E-commerce Union Integration
class EcommerceViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEcommerceIntegration()
    }
    
    private func setupEcommerceIntegration() {
        // Configure e-commerce extra info
        let extraInfo = KSEUExtraInfo(promoteID: "your-promote-id", comment: "user_purchase")
        extraInfo.userCommRateBuying = 5  // 5% commission for user purchases
        extraInfo.userCommRateSharing = 3 // 3% commission for user shares
        
        // Create content page with e-commerce support
        let contentPage = KSCUContentPage(posId: "your-ecommerce-pos-id", 
                                          promoteID: extraInfo.promoteID, 
                                          comment: extraInfo.comment)
        
        contentPage.callBackDelegate = self
        
        // Present the content page
        present(contentPage.viewController, animated: true)
    }
}

extension EcommerceViewController: KSCUContentPageCallBackProtocol {
    func kscuSaleListDidClick(_ liveId: String) {
        print("Sale list clicked for live ID: \(liveId)")
    }
    
    func kscuBuyButtonDidClick(_ liveId: String) {
        print("Buy button clicked for live ID: \(liveId)")
        // Handle purchase flow
    }
} 