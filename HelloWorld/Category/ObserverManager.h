//
//  ObserverManager.h
//  HelloWorld
//
//  Created by test on 2018/1/4.
//  Copyright © 2018年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObserverModel.h"

@interface ObserverManager : NSObject


@property (nonatomic, strong) NSMutableArray *observerArray;

+ (instancetype)sharedInstance;

- (void)removeModel:(ObserverModel *)model;

//- (ObserverModel *)checkModelExists:(NSObject *)observer keyPath:(NSString *)keyPath;

- (ObserverModel *)checkModelExists:(ObserverModel *)model;

@end
