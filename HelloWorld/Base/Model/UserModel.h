//
//  UserModel.h
//  HelloWorld
//
//  Created by test on 2018/1/8.
//  Copyright © 2018年 test. All rights reserved.
//

#import "BaseModel.h"
#import "UserInfoModel.h"

@interface UserModel : BaseModel

@property (nonatomic, copy) NSString *userName;
@property (nonatomic) NSInteger age;
@property (nonatomic) BOOL state;
@property (nonatomic, strong) UserInfoModel *userInfo;


@end
