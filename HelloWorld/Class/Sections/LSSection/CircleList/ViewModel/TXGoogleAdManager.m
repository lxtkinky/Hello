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

@interface TXGoogleAdManager()<GADBannerViewDelegate>

@property (nonatomic, strong) GADBannerView *bannerView;

@end

@implementation TXGoogleAdManager

/*
 #define movieBoxKey @"ca-app-pub-5735364568535755/6293430024"
 #define movieBoxOtherKey @"ca-app-pub-5735364568535755/6691771223"
 #define playBoxHDKey @"ca-app-pub-5735364568535755/6014228424"
 */

- (void)showGoogleAdWithController:(UIViewController *)controller{
    //ca-app-pub-6588575820465593~7644925034
//    [GADMobileAds configureWithApplicationID:@"ca-app-pub-6588575820465593~7644925034"];
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-3940256099942544~1458002511"];//测试
    
    self.bannerView = [[GADBannerView alloc] init];
    self.bannerView.delegate = self;
    //ca-app-pub-6588575820465593/5681817116
//    self.bannerView.adUnitID = @"ca-app-pub-6588575820465593/5681817116";
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";//测试
    self.bannerView.rootViewController = controller;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ @"4a39811ef2af17c0ef6e50cfcd42e434" ];
    
//    request.testDevices = @[kGADSimulatorID];
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
