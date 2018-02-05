//
//  ObserverModel.m
//  HelloWorld
//
//  Created by test on 2018/1/4.
//  Copyright © 2018年 test. All rights reserved.
//

#import "ObserverModel.h"

@implementation ObserverModel

//+ (ObserverModel *)observerModeWithTarget:(id)target keyPath:(NSString *)keyPath{
//    ObserverModel *model = [[ObserverModel alloc] init];
//    model.observer = target;
//    model.keyPath = keyPath;
//    return model;
//}

+ (ObserverModel *)observerModeWithSource:(id)source observer:(id)observer keyPath:(NSString *)keyPath{
    ObserverModel *model = [[ObserverModel alloc] init];
//    model.source = source;
    model.observer = observer;
    model.keyPath = keyPath;
    return model;
}

@end
