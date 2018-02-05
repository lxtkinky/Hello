//
//  ObserverManager.m
//  HelloWorld
//
//  Created by test on 2018/1/4.
//  Copyright © 2018年 test. All rights reserved.
//

#import "ObserverManager.h"

static ObserverManager *instance = nil;

@implementation ObserverManager

- (NSMutableArray *)observerArray{
    if (!_observerArray) {
        _observerArray = [NSMutableArray array];
    }
    
    return _observerArray;
}

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ObserverManager alloc] init];
    });
    return instance;
}

- (void)removeModel:(ObserverModel *)model{
    [self.observerArray removeObject:model];
}

//- (ObserverModel *)checkModelExists:(NSObject *)observer keyPath:(NSString *)keyPath{
//    for (ObserverModel *model in self.observerArray) {
//        if ([model.observer isEqual:observer] && [model.keyPath isEqualToString:keyPath]) {
//            return model;
//        }
//    }
//    return nil;
//}

- (ObserverModel *)checkModelExists:(ObserverModel *)model{
    for (ObserverModel *observerModel in self.observerArray) {
        if ([observerModel.observer isEqual:model.observer] && [observerModel.keyPath isEqualToString:model.keyPath] && [observerModel.source isEqual:model.source]) {
            return observerModel;
        }
    }
    return nil;
}

@end
