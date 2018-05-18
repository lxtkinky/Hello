//
//  TXEncryptTool.m
//  HelloWorld
//
//  Created by ken on 2018/5/9.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXEncryptTool.h"
#import "EasyHelper.h"
#import "NSString+AES.h"

static NSString *salt = @"irCbqk5WZSW639Eo";

@implementation TXEncryptTool

+ (NSString *)socketEncryptKey{
    NSString *secretKey = @"";
    NSString * dateString = [EasyHelper dateWithGMT];
    NSString *noneStr = [self noneStr];
    NSString * token = [NSString stringWithFormat:@"%@%@", dateString, noneStr];
    token = [EasyHelper hmacSha256:token hmacKey:salt];
    
    secretKey = [secretKey stringByAppendingFormat:@"time=%@", [dateString URLEncode]];
    secretKey = [secretKey stringByAppendingFormat:@"&nonce=%@", [noneStr URLEncode]];
    secretKey = [secretKey stringByAppendingFormat:@"&token=%@", [token URLEncode]];
    return secretKey;
}

+ (NSString *)noneStr{
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
//    NSLog(@"noneStr = %@", noneStr);
    
    
    
    return noneStr;
}

@end
