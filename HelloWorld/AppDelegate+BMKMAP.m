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
//#import <UMCommon/UMCommon.h>
#import <BmobSDK/Bmob.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

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

- (void)startNetworkMonitor{
    [[TXNetworkHelper sharedInstance] startNetworkReach];
}

/**初始化友盟的所有组件
 * appKey 开发者在友盟官网申请的AppKey
 * channel 渠道标识，可设置nil表示"App Store".
 */
- (void)configUShare{
//    NSString *appKey = @"5afe32dca40fa307a6000182";
//    NSString *appStore = nil;
//    [UMConfigure initWithAppkey:appKey channel:appStore];
}

- (void)configThirdComments{
    [self configUShare];
    
    [self configKeyboard];
}

- (void)configBmob{
    [Bmob registerWithAppKey:@""];
}

- (void)configKeyboard{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}

@end
