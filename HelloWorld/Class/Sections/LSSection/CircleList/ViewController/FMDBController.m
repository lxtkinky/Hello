//
//  FMDBController.m
//  HelloWorld
//
//  Created by test on 2018/1/12.
//  Copyright © 2018年 test. All rights reserved.
//

#import "FMDBController.h"
#import "FMDBManager.h"
#import "FMDB.h"

@interface FMDBController ()

@end

@implementation FMDBController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FMDatabase *dataBase = [FMDBManager sharedInstance].dataBase;
    if ([dataBase open]) {
        NSString *selectStr = [NSString stringWithFormat:@"create table 'person'('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, 'username' varchar(255), 'age' integer,'password' varchar(255))"];
        [dataBase executeQuery:selectStr];
    }
    else{
        NSLog(@"打开连接失败");
    }
    if (![dataBase close]) {
        NSLog(@"关闭连接失败");
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
