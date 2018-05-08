//
//  DefineMacro.h
//  HelloWorld
//
//  Created by test on 2018/1/4.
//  Copyright © 2018年 test. All rights reserved.
//

#ifndef DefineMacro_h
#define DefineMacro_h

#define WeakSelf __weak typeof(self) weakSelf = self;

#define WeakType(type) __weak typeof(type) weak##type = type;
#define StrongType(type)  __strong typeof(type) type = weak##type;

//单例模式定义
#define TX_SINGLETON_DEF(_type_) + (_type_ *)sharedInstance;\
+(instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));\
+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));\

//单例模式实现
#define TX_SINGLETON_IMP(_type_) + (_type_ *)sharedInstance{\
static _type_ *theSharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
theSharedInstance = [[super alloc] init];\
});\
return theSharedInstance;\
}


#endif /* DefineMacro_h */
