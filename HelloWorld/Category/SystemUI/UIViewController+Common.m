//
//  UIViewController+Common.m
//  HelloWorld
//
//  Created by test on 2018/1/4.
//  Copyright © 2018年 test. All rights reserved.
//

#import "UIViewController+Common.h"
#import <objc/runtime.h>

const static char userNameKey;

@implementation UIViewController (Common)
/**不能覆盖此方法 覆盖该方法有可能会导致未知错误*/
//- (void)dealloc{
//    NSLog(@"*****************%@:%@ dealloc**************************", [self class], self);
//}


+ (void)load{
    [self swizzlingViewDidLoad];
}

+ (void)swizzlingViewDidLoad{
    SEL oldSel = @selector(viewDidLoad);
    SEL newSel = @selector(lxt_viewDidLoad);
    
    Method oldMethod = class_getInstanceMethod([self class], oldSel);
    Method newMethod = class_getInstanceMethod([self class], newSel);
    
    method_exchangeImplementations(oldMethod, newMethod);
}

- (void)lxt_viewDidLoad{
    NSLog(@"====%@=====", self);
//    [self.rac_willDeallocSignal subscribeCompleted:^{
//        NSLog(@"*************dealloc*****************");
//    }];
    
    [self lxt_viewDidLoad];
}


- (NSString *)userName{
    return objc_getAssociatedObject(self, &userNameKey);
}

- (void)setUserName:(NSString *)userName{
    objc_setAssociatedObject(self, &userNameKey, userName, OBJC_ASSOCIATION_COPY);
}

@end
