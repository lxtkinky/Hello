//
//  NSString+Secret.h
//  SecretDemo
//
//  Created by HUIDUOLA on 2019/4/3.
//  Copyright © 2019 HUIDUOLA. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Secret)

- (NSString*) sha1;

-(NSString *) md5;

- (NSString *) sha1_base64;

- (NSString *) md5_base64;

- (NSString *) base64;

- (NSString *)sha256;

@end

NS_ASSUME_NONNULL_END
