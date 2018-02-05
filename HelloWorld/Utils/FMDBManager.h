//
//  FMDBManager.h
//  HelloWorld
//
//  Created by test on 2018/1/12.
//  Copyright © 2018年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface FMDBManager : NSObject

@property (nonatomic, strong) FMDatabase *dataBase;

+ (instancetype)sharedInstance;

@end
