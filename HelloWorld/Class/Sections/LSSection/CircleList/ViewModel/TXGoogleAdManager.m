//
//  TXGoogleAdManager.m
//  HelloWorld
//
//  Created by lixt on 2018/2/5.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXGoogleAdManager.h"
//#import <GoogleMobileAds/GoogleMobileAds.h>
#import <GoogleMobileAds/GoogleMobileAds.h>


/*
 //
NSString *GADAppID = @"ca-app-pub-6588575820465593~7644925034";
NSString *GADInterstitialID = @"ca-app-pub-6588575820465593/3375150101";
NSString *GADBannerID = @"ca-app-pub-6588575820465593/5681817116";
 
 #define movieBoxKey @"ca-app-pub-5735364568535755/6293430024"
 #define movieBoxOtherKey @"ca-app-pub-5735364568535755/6691771223"
 #define playBoxHDKey @"ca-app-pub-5735364568535755/6014228424"
 */


NSString *GADAppID = @"ca-app-pub-6588575820465593~7644925034";
NSString *GADInterstitialID = @"ca-app-pub-6588575820465593/3375150101";
NSString *GADBannerID = @"ca-app-pub-6588575820465593/5681817116";

//googleAD
NSString *GADTestAppID = @"ca-app-pub-3940256099942544~1458002511";
NSString *GADTestBannerID = @"ca-app-pub-3940256099942544/2934735716";
NSString *GADTestInterstitialID = @"ca-app-pub-3940256099942544/4411468910";

@interface TXGoogleAdManager()<GADBannerViewDelegate,GADInterstitialDelegate>

@property (nonatomic, strong) GADBannerView *bannerView;
@property (nonatomic, strong) GADInterstitial *interstitial;
@property (nonatomic, strong) UIViewController *controller;
@end

@implementation TXGoogleAdManager

/*
 #define movieBoxKey @"ca-app-pub-5735364568535755/6293430024"
 #define movieBoxOtherKey @"ca-app-pub-5735364568535755/6691771223"
 #define playBoxHDKey @"ca-app-pub-5735364568535755/6014228424"
 */



- (void)showGoogleAdWithController:(UIViewController *)controller{
    self.controller = controller;
    [self interstitialID:controller];
}

- (void)interstitialID:(UIViewController *)controller{
//    [GADMobileAds configureWithApplicationID:GADTestAppID];
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:GADTestInterstitialID];
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ @"4a39811ef2af17c0ef6e50cfcd42e434" ];
    [self.interstitial loadRequest:request];
}

//banner广告
- (void)bannerAD:(UIViewController *)controller{
//    [GADMobileAds configureWithApplicationID:GADTestAppID];//Google提供的APP测试广告ID，如果要测试自己的广告请替换自己的APP广告ID
    
    self.bannerView = [[GADBannerView alloc] init];
    self.bannerView.delegate = self;
    self.bannerView.adUnitID = GADTestBannerID;////Google提供的Banner测试广告ID，如果要测试自己的广告请替换自己的banner广告ID
    self.bannerView.rootViewController = controller;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ @"4a39811ef2af17c0ef6e50cfcd42e434" ];
    
    [self.bannerView loadRequest:request];
    [controller.view addSubview:self.bannerView];
    
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *Hvfl = @"H:|-0-[_bannerView]-0-|";
    NSString *Vvfl = @"V:[_bannerView(80)]-0-|";
    NSDictionary *views = NSDictionaryOfVariableBindings(_bannerView);
    NSArray *Hconstraints = [NSLayoutConstraint constraintsWithVisualFormat:Hvfl options:0 metrics:nil views:views];
    NSArray *Vconstraints = [NSLayoutConstraint constraintsWithVisualFormat:Vvfl options:0 metrics:nil views:views];
    [controller.view addConstraints:Hconstraints];
    [controller.view addConstraints:Vconstraints];
}


- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    NSLog(@"interstitialDidReceiveAd");
    [self.interstitial presentFromRootViewController:self.controller];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"didFailToReceiveAdWithError");
}

#pragma mark Display-Time Lifecycle Notifications

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad{
    NSLog(@"interstitialWillPresentScreen");
}

- (void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad{
    NSLog(@"interstitialDidFailToPresentScreen");
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad{
    NSLog(@"interstitialWillDismissScreen");
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    NSLog(@"interstitialDidDismissScreen");
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
    NSLog(@"interstitialWillLeaveApplication");
}

#pragma mark - BannerViewDelegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    NSLog(@"adViewDidReceiveAd");
}

/// Tells the delegate that an ad request failed. The failure is normally due to network
/// connectivity or ad availablility (i.e., no fill).
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"fail to add AD %@", error.userInfo);
}

#pragma mark Click-Time Lifecycle Notifications

/// Tells the delegate that a full screen view will be presented in response to the user clicking on
/// an ad. The delegate may want to pause animations and time sensitive interactions.
- (void)adViewWillPresentScreen:(GADBannerView *)bannerView{
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)bannerView{
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full screen view has been dismissed. The delegate should restart
/// anything paused while handling adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(GADBannerView *)bannerView{
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that the user click will open another app, backgrounding the current
/// application. The standard UIApplicationDelegate methods, like applicationDidEnterBackground:,
/// are called immediately before this method is called.
- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView{
    NSLog(@"adViewWillLeaveApplication");
}

@end
