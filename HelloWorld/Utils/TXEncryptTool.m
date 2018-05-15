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

@implementation TXEncryptTool

+ (NSString *)socketEncryptKey{
    NSString *secretKey = @"";
    NSString * dateString = [EasyHelper dateWithGMT];
    NSString *noneStr = @"0XJgNgXn60e4ubcZ ";
    NSString * token = [NSString stringWithFormat:@"%@%@", dateString, noneStr];
    token = [EasyHelper hmacSha256:token hmacKey:@"H6J4AzqYDpVK8ZM5A5GfJSROJw"];
    
    secretKey = [secretKey stringByAppendingFormat:@"time=%@", [dateString URLEncode]];
    secretKey = [secretKey stringByAppendingFormat:@"&nonce=%@", [noneStr URLEncode]];
    secretKey = [secretKey stringByAppendingFormat:@"&token=%@", [token URLEncode]];
    return secretKey;
}

@end
