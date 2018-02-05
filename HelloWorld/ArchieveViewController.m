//
//  ArchieveViewController.m
//  HelloWorld
//
//  Created by test on 2018/1/8.
//  Copyright © 2018年 test. All rights reserved.
//

#import "ArchieveViewController.h"
#import "BaseModel.h"
#import "UserModel.h"
#import "UserInfoModel.h"

@interface ArchieveViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ArchieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 10; i++) {
        UserModel *model = [[UserModel alloc] init];
        model.userName = [NSString stringWithFormat:@"lixt%d", i];
        model.age = 10;
        model.state = YES;
        
        UserInfoModel *userInfo = [[UserInfoModel alloc] init];
        userInfo.city = [NSString stringWithFormat:@"city%d", i];
        userInfo.age = model.age + 10;
        userInfo.state = !model.state;
        model.userInfo = userInfo;
        
        [self.dataArray addObject:model];
    }
    
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"test.plist"];
    if ([NSKeyedArchiver archiveRootObject:self.dataArray toFile:path]) {
        NSLog(@"归档成功！");
    }
    
    self.dataArray = nil;
    
    self.dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    for (UserModel *model in self.dataArray) {
        NSLog(@"%@---%ld---%d", model.userName, model.age, model.state);
        NSLog(@"%@---%ld---%d", model.userInfo.city, model.userInfo.age, model.userInfo.state);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
