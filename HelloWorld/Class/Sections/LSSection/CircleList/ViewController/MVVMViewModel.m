//
//  MVVMViewModel.m
//  HelloWorld
//
//  Created by lixt on 2018/4/13.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "MVVMViewModel.h"

@implementation MVVMViewModel

- (void)loadData{
    if (self.loadDataSuccess) {
        self.loadDataSuccess();
    }
}

@end
