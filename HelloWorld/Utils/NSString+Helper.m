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

+ (NSString *)randomString{
    NSMutableString *noneStr = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            [noneStr appendFormat:@"%d", number];
        }
        else{
            char character = number - 10 + 97;
            [noneStr appendFormat:@"%c", character];
        }
    }
    return noneStr;
}

-(BOOL)IsChinese:(NSString *)str
{
    NSInteger count = str.length;
    NSInteger result = 0;
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            result++;
        }
    }
    if (count == result) {//当字符长度和中文字符长度相等的时候
        return YES;
    }
    return NO;
}


@end
