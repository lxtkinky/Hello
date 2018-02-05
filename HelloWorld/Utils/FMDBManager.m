//
//  FMDBManager.m
//  HelloWorld
//
//  Created by test on 2018/1/12.
//  Copyright © 2018年 test. All rights reserved.
//

#import "FMDBManager.h"

static id instance = nil;

@interface FMDBManager()



@end

@implementation FMDBManager

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FMDBManager alloc] init];
    });
    return instance;
}




- (FMDatabase *)dataBase{
    if (!_dataBase) {
        NSString *urlStr = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"HelloWorld.db"];
        _dataBase = [FMDatabase databaseWithPath:urlStr];
    }
    return _dataBase;
}

@end
