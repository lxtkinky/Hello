//
//  NSString+Hash.m
//  HelloWorld
//
//  Created by lixt on 2018/3/29.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "NSString+Hash.h"
#import <CommonCrypto/CommonCrypto.h>
#import <objc/runtime.h>

static char *md5StrKey = "md5String";

@implementation NSString (Hash)


- (NSString *)md5String{
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str,(CC_LONG) strlen(str), buffer);
    return [self stringFromBytes:buffer lenth:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(uint8_t *)bytes lenth:(int)lenth{
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < lenth; i++) {
        [str appendFormat:@"%02x", bytes[i]];
    }
    return [str copy];
}

- (NSString *)hmacMd5StringWithKey:(NSString *)key{
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    u_int8_t buffer[CC_MD5_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer lenth:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key{
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    u_int8_t buffer[CC_MD5_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer lenth:CC_MD5_DIGEST_LENGTH];
}

@end
