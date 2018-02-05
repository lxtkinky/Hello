//
//  ViewModel.m
//  HelloWorld
//
//  Created by test on 17/12/18.
//  Copyright © 2017年 test. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel

- (void)requestDataWithPull:(BOOL)pull{
    if (pull) {
        self.dataArray = [NSMutableArray array];
    }
    for (int i = 0; i< 10; i++) {
//        [_dataArray addObject:[[UserEntity alloc] init]];
    }
    
    [self.tableSubject sendNext:@(pull)];
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tableSubject = [RACSubject subject];
    }
    return self;
}

@end
