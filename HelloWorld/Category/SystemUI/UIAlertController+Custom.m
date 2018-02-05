//
//  UIAlertController+Custom.m
//  HelloWorld
//
//  Created by test on 2017/12/29.
//  Copyright © 2017年 test. All rights reserved.
//

#import "UIAlertController+Custom.h"

@implementation UIAlertController (Custom)

- (void)setTitleFont:(UIFont *)font color:(UIColor *)color{
    NSMutableAttributedString *titleAttrStr = [[NSMutableAttributedString alloc] initWithString:self.title];
    [titleAttrStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, titleAttrStr.length)];
    [titleAttrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, titleAttrStr.length)];
    [self setValue:titleAttrStr forKey:@"attributedTitle"];
}

- (void)setmessageFont:(UIFont *)font color:(UIColor *)color{
    NSMutableAttributedString *alertMsgAttrStr = [[NSMutableAttributedString alloc] initWithString:self.message];
    [alertMsgAttrStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, alertMsgAttrStr.length)];
    [alertMsgAttrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, alertMsgAttrStr.length)];
    [self setValue:alertMsgAttrStr forKey:@"attributedMessage"];
}

@end
