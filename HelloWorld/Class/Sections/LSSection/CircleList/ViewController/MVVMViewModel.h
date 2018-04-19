//
//  MVVMViewModel.h
//  HelloWorld
//
//  Created by lixt on 2018/4/13.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LoadDataSuccess)();

@interface MVVMViewModel : NSObject

@property (nonatomic, strong) LoadDataSuccess loadDataSuccess;

- (void)loadData;

@end
