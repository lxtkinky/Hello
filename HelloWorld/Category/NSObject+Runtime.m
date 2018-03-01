//
//  NSObject+Runtime.m
//  HelloWorld
//
//  Created by test on 2018/1/4.
//  Copyright © 2018年 test. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>
#import "ObserverModel.h"
#import "ObserverManager.h"

@implementation NSObject (Runtime)

+ (void)load{
//    [self exchangeObserverMethod];
}

/*交换KVO相关方法**/
//可能导致未知错误 比如AVplayer使用出现移除currentItemKVO错误而导致崩溃
+ (void)exchangeObserverMethod{
    SEL addObserverSel = @selector(addObserver:forKeyPath:options:context:);
    SEL removeObserverSel = @selector(removeObserver:forKeyPath:);
    SEL myAddObserverSel = @selector(lxt_addObserver:forKeyPath:options:context:);
    SEL myRemoveObserverSel = @selector(lxt_removeObserver:forKeyPath:);
    
    Method addObserverMethod = class_getInstanceMethod([self class], addObserverSel);
    Method removeObserverMethod = class_getInstanceMethod([self class], removeObserverSel);
    Method myAddObserverMethod = class_getInstanceMethod([self class], myAddObserverSel);
    Method myRemoveObserverMethod = class_getInstanceMethod([self class], myRemoveObserverSel);
    
    method_exchangeImplementations(addObserverMethod, myAddObserverMethod);
    method_exchangeImplementations(removeObserverMethod, myRemoveObserverMethod);
}


- (void)lxt_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    if (![self observerKeyPath:keyPath]) {
        NSLog(@"add observer source:%@,observer:%@,keyPath:%@", self, observer, keyPath);
        [self lxt_addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)lxt_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    if ([self observerKeyPath:keyPath]) {
        @try{
            NSLog(@"remove observer observer:%@,keyPath:%@", observer, keyPath);
            [self lxt_removeObserver:observer forKeyPath:keyPath];
        }@catch(NSException *exception){
            NSLog(@"%@", exception);
        }
       
    }
}

- (BOOL)observerKeyPath:(NSString *)key{
    id info = self.observationInfo;
    NSArray *array = [info valueForKey:@"_observances"];
    for (id objc in array) {
        id properties = [objc valueForKey:@"_property"];
        NSString *keyPath = [properties valueForKey:@"_keyPath"];
        if ([key isEqualToString:keyPath]) {
            return YES;
        }
    }
    return NO;
}


/*
- (void)lxt_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    ObserverModel *model = [ObserverModel observerModeWithSource:self observer:observer keyPath:keyPath];
    if (![[ObserverManager sharedInstance] checkModelExists:model]) {
        NSLog(@"add observer source:%@,observer:%@,keyPath:%@", self, observer, keyPath);
        [[ObserverManager sharedInstance].observerArray addObject:model];
        [self lxt_addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)lxt_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    //如果是ViewController 在dealloc方法中移除监听找不到相应的ObserverModel,因为该model中的observer使用weak修饰自动设置为nil了，如果改成strong那么将导致controller无法释放
    @try{
        if ([observer isKindOfClass:[UIViewController class]]) {
            NSLog(@"remove observer source:%@,observer:%@,keyPath:%@", self, observer, keyPath);
            [self lxt_removeObserver:observer forKeyPath:keyPath];
            return;
        }
        ObserverModel *newModel = [ObserverModel observerModeWithSource:self observer:observer keyPath:keyPath];
        ObserverModel *model = [[ObserverManager sharedInstance] checkModelExists:newModel];
        if (model) {
            NSLog(@"remove observer source:%@,observer:%@,keyPath:%@", self, observer, keyPath);
            [[ObserverManager sharedInstance] removeModel:model];
            [self lxt_removeObserver:observer forKeyPath:keyPath];
        }
    }
    @catch(NSException *exception){
        NSLog(@"%@", exception);
    }
    
}
 */

#pragma mark - //手动实现KVO
/**
 1、添加一个子类
 2、给子类添加一个setter方法
 3、绑定observer 再setter方法中调用observer方法
 */

- (void)tx_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    Class superClass = [self class];
    NSString *className = [NSString stringWithFormat:@"KVONotifying_%s", class_getName(superClass)];
    Class myClass = objc_allocateClassPair(superClass, [className UTF8String], 0);
    objc_registerClassPair(myClass);      //注册类  否则无法使用
    object_setClass(self, myClass);     //修改调用者类型
    
    //绑定observer
    objc_setAssociatedObject(self, "observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //这里的方法名应该是拿到keypath然后首字母大写再加上set
    NSString *firstUpStr = [[keyPath substringWithRange:NSMakeRange(0, 1)] uppercaseString];
    NSString *methodName = [NSString stringWithFormat:@"set%@%@:", firstUpStr, [keyPath substringWithRange:NSMakeRange(1, keyPath.length - 1)]];
    class_addMethod(myClass, NSSelectorFromString(methodName), (IMP)hello, "");
    
}

//这里传递的的参数如何做到 可以接受任何类型????
void hello(id self, SEL _cmd,int age){
    NSString *methodName = NSStringFromSelector(_cmd);
    NSString *keypath = [[methodName substringWithRange:NSMakeRange(3, methodName.length - 4)] lowercaseString];
    NSObject *observer = objc_getAssociatedObject(self, "observer");
    NSObject *oldValue = [self valueForKey:keypath];
    if (oldValue == nil) {
        oldValue = [NSNull null];
    }
    [self setValue:@(age) forKey:keypath];
    NSObject *newValue = [self valueForKey:keypath];
    if (newValue == nil) {
        newValue = [NSNull null];
    }
    [observer observeValueForKeyPath:keypath ofObject:self change:@{NSKeyValueChangeNewKey : newValue, NSKeyValueChangeOldKey : oldValue} context:nil];
}



@end
