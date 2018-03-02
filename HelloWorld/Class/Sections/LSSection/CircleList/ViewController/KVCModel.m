//
//  KVCModel.m
//  HelloWorld
//
//  Created by ken on 2018/3/1.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "KVCModel.h"

@implementation KVCModel

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        //KVC会按如下顺序去找成员变量
//        _name = @"_name";
//        _isName = @"_isName";
//        name = @"name";
//        isName = @"isName";
//    }
//    return self;
//}


/*
 KVC valueForKeypath:keypath 可以对象关联对象的属性：model.dog.age 获取对象的dog属性的age属性
 KVC valueForKey:key  首先会调用accessInstanceVariablesDirectly
 1、首先调用getter方法,getKey-->key-->isKey-->_getKey-->_key
 2、如果没有相关方法会去找countOfKey 和 objectInNameAtIndex:index方法 这两个方法会返回一个NSKeyValueArray数组对象
 3、如果上述方法都没有，看+ (BOOL)accessInstanceVariablesDirectly 返回值
    如果为YES，找成员变量，_key-->_isKey-->key-->isKey
    如果为NO，报错
 4、还可以实现valueForUndefinedKey 返回nil 这样就不会报错
 */

//返回NO 通过KVC访问属性会直接报错
+ (BOOL)accessInstanceVariablesDirectly{
    return YES;
}

- (NSString *)getName{
    return @"lixt-->getName";
}

- (NSString *)name{
    return @"lixt-->name";
}

- (NSString *)isName{
    return @"lixt-->isName";
}

- (NSString *)_getName{
    return @"lixt-->_getName";
}

- (NSString *)_name{
    return @"lixt-->_name";
}








//- (NSInteger)countOfName{
//    return 10;
//}
//
//- (id)objectInNameAtIndex:(NSInteger)index{
//    return @"objc";
//}



- (id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"%@不能获取key:%@的值，没有这个key",self, key);
    return nil;
}



/*
 KVC setValue:value forKey:key 查找相关的setter方法
 setter方法顺序：setKey-->_setKey-->setIsKey
 //如果属性的类型为基本数据类型，赋值的时候传递的是nil对象则会报错，可以实现setNilValueForKey:key 方法处理错误
 */

- (void)setName:(NSString *)name{
    NSLog(@"setName:%@", name);
    _name = name;
}

- (void)_setName:(NSString *)name{
    NSLog(@"_setName:%@", name);
    _name = name;
}

- (void)setIsName:(NSString *)isName{
    NSLog(@"setIsName:%@", isName);
    _name = isName;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@不能为key:%@赋值,没有这个key",self, key);
}

//如果属性的类型为基本数据类型，赋值的时候传递的是nil对象则会报错，可以实现setNilValueForKey:key 方法处理错误
- (void)setNilValueForKey:(NSString *)key{
    
    NSLog(@"%@的key:%@ 不能设置为nil",self, key.capitalizedString);
}



@end
