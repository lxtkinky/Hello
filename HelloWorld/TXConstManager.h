//
//  TXConstManager.h
//  HelloWorld
//
//  Created by HUIDUOLA on 2019/4/1.
//  Copyright © 2019 Sheng Yuan Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NSString * const author = @"lixt";  //只读变量 可使用extern改为外部连接,作用域扩大至全局

@interface TXConstManager : NSObject

@end

NS_ASSUME_NONNULL_END
