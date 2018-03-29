//
//  NSString+Hash.h
//  HelloWorld
//
//  Created by lixt on 2018/3/29.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)

/**
 计算MD5散列结果
 终端命令：md5 -s "123456"
 */
@property (nonatomic, copy) NSString *md5String;

- (NSString *)hmacMd5StringWithKey:(NSString *)key;

/**
 计算SHA1散列结果
 终端命令：echo -n "123456" | openssl sha sha1 可通过SHA1散列结果再加时间戳（精确到分钟）校验，防止截取密文模拟登陆
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 计算SHA256散列结果
 终端命令：echo -n "123456" | openssl sha sha256
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

@end
