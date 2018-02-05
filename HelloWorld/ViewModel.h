//
//  ViewModel.h
//  HelloWorld
//
//  Created by test on 17/12/18.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewModel : NSObject


@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) RACSubject *tableSubject;

- (void)requestDataWithPull:(BOOL)pull;

@end
