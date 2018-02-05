//
//  AppDelegate+BMKMAP.m
//  HelloWorld
//
//  Created by test on 17/12/21.
//  Copyright © 2017年 test. All rights reserved.
//

#import "AppDelegate+BMKMAP.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import <AlipaySDK/AlipaySDK.h>

//extern BMKMapManager *mapManager;
//
//@interface AppDelegate(BMKMAP) <BMKGeneralDelegate>
//
//@end

@implementation AppDelegate (BMKMAP)

//- (void)startBMKMap{
//    mapManager = [[BMKMapManager alloc] init];
//    
//    [mapManager start:@"" generalDelegate:self];
//}
//
/**
 *返回网络错误
 *@param iError 错误号
 */
- (void)onGetNetworkState:(int)iError{
    
}

/**
 *返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
 */
- (void)onGetPermissionState:(int)iError{
    
}

//检测支付宝链接
- (void)aliapyWithURL:(NSURL *)url{
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"resultDic=%@", resultDic);
        }];
    }
    
    if ([url.host isEqualToString:@"platformapi"]) {//支付宝钱包快登授权返回authCode
        
        //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"resultDic=%@", resultDic);
        }];
    }
}

@end
