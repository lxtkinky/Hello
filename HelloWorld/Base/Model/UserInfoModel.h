//
//  UserInfoModel.h
//  HelloWorld
//
//  Created by test on 2018/1/8.
//  Copyright © 2018年 test. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel

@property (nonatomic, copy) NSString *city;
@property (nonatomic) NSInteger age;
@property (nonatomic) BOOL state;

@end
