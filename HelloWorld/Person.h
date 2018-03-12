//
//  Person.h
//  HelloWorld
//
//  Created by ken on 2018/2/27.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Dog.h"

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic) NSInteger age;
@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) Dog *dog;

@end
