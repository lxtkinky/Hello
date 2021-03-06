//
//  BaseModel.m
//  HelloWorld
//
//  Created by test on 2018/1/8.
//  Copyright © 2018年 test. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
//        const char *propertyValue = property_getAttributes(properties[i]);
        NSString *key = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSObject *value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        u_int count = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(properties[i]);
            NSString *key = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
            NSObject *value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
    }
    return self;
}

+ (instancetype)modelFromDict:(NSDictionary *)dict{
    id model = [[self alloc] init];
    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        NSString *propertyName = [NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
        NSValue *value = [dict objectForKey:propertyName];
        [model setValue:value forKey:propertyName];
    }
    return model;
}

- (void)test{
    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
//        const char *propertyValue = property_getAttributes(properties[i]);
        NSObject *value = [self valueForKey:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        NSLog(@"%s----------%@", propertyName, value);
        
    }
}

- (id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"%@不能获取key:%@的值，没有这个key",self, key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@不能为key:%@赋值,没有这个key",self, key);
}

- (void)setNilValueForKey:(NSString *)key{
    NSLog(@"%@的属性:%@不能设置为nil",self, key);
}

@end
