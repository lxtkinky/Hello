//
//  TXQRCodeManager.h
//  TestDemo003
//
//  Created by ken on 2018/5/8.
//  Copyright © 2018年 lixt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface TXQRCodeManager : NSObject

+ (instancetype)sharedInstance;

- (void)scanQRCodeAtView:(UIView *)view;

- (NSMutableArray *)scanQRCodeFromImage:(UIImage *)image;

- (UIImage *)createQRCodeWithString:(NSString *)string;

@end
