//
//  NSString+Helper.m
//  HelloWorld
//
//  Created by ken on 2018/5/15.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)


- (CGFloat)getHeightWithWidth:(CGFloat)width font:(UIFont *)font{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    NSDictionary *dict = @{NSFontAttributeName : font, NSParagraphStyleAttributeName : style};
    CGFloat height = [self boundingRectWithSize:size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    return height;
}


@end
