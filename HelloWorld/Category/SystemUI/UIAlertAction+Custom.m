//
//  UIAlertAction+Custom.m
//  HelloWorld
//
//  Created by test on 2017/12/29.
//  Copyright © 2017年 test. All rights reserved.
//

#import "UIAlertAction+Custom.h"

@implementation UIAlertAction (Custom)

- (void)setTitleColor:(UIColor *)color{
    [self setValue:color forKey:@"titleTextColor"];
}

@end
