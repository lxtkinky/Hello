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
 终端命令：echo -n "123456" | openssl sha sha1 、
 可通过SHA1散列结果再加时间戳（精确到分钟,服务器可校验当前时间，若校验失败则校验前一分钟，否则校验失败）校验，防止截取密文模拟登陆
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 计算SHA256散列结果
 终端命令：echo -n "123456" | openssl sha sha256
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

/**
 rsa
 生成秘钥：openssl genrsa -out private.pem 512
 生成公钥：openssl rsa -in private.pem -out public.pem -pubout
 转换成明文：openssl rsa -in private.pem -text -out private1.txt
 核心数据加密用C方法
 */

@end
