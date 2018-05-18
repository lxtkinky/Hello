//
//  TXSpringAnimation.h
//  HelloWorld
//
//  Created by ken on 2018/5/18.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXSpringAnimation : NSObject

+(NSMutableArray *) animationValues:(id)fromValue toValue:(id)toValue usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity duration:(CGFloat)duration;

+(CAKeyframeAnimation *)createSpring:(NSString *)keypath duration:(CFTimeInterval)duration usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity fromValue:(id)fromValue toValue:(id)toValue;

@end
