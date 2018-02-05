//
//  AppDelegate+BMKMAP.h
//  HelloWorld
//
//  Created by test on 17/12/21.
//  Copyright © 2017年 test. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (BMKMAP)

- (void)startBMKMap;

/**检测支付宝链接*/
- (void)aliapyWithURL:(NSURL *)url;

@end
