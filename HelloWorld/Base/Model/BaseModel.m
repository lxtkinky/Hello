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
@end
