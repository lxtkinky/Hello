//
//  ObserverModel.h
//  HelloWorld
//
//  Created by test on 2018/1/4.
//  Copyright © 2018年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObserverModel : NSObject

@property (nonatomic, weak) id source;
@property (nonatomic, weak) id observer;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, copy) NSString *context;

//+ (ObserverModel *)observerModeWithTarget:(id)target keyPath:(NSString *)keyPath;
+ (ObserverModel *)observerModeWithSource:(NSObject *)source observer:(NSObject *)observer keyPath:(NSString *)keyPath;

@end
