//
//  LTImageUtil.h
//  
//
//  Created by test on 2017/12/29.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface LTImageUtil : NSObject

+ (void)imageView:(UIImageView *)imageView imageURL:(NSString *)imageURL placeholder:(NSString *)placeholder;

@end
