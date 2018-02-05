//
//  LTImageUtil.m
//  
//
//  Created by test on 2017/12/29.
//

#import "LTImageUtil.h"

@implementation LTImageUtil

+ (void)imageView:(UIImageView *)imageView imageURL:(NSString *)imageURL placeholder:(NSString *)placeholder{
    imageURL = @"http://61.155.215.48:5000/static/upload/15603077930.jpg";
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:placeholder]];
}

@end
