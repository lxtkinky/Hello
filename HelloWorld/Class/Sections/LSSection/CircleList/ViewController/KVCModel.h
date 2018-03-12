//
//  KVCModel.h
//  HelloWorld
//
//  Created by ken on 2018/3/1.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "BaseModel.h"

@interface KVCModel : BaseModel{
    //KVC会按如下顺序去找成员变量
    NSString *_name;
    NSString *_isName;
    NSString *name;
    NSString *isName;
    NSInteger age;
}

@end
