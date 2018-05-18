//
//  TXSpringAnimation.m
//  HelloWorld
//
//  Created by ken on 2018/5/18.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXSpringAnimation.h"

@implementation TXSpringAnimation

+(NSMutableArray *) animationValues:(id)fromValue toValue:(id)toValue usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity duration:(CGFloat)duration{
    //60个关键帧
    NSInteger numOfPoints  = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfPoints];
    for (NSInteger i = 0; i < numOfPoints; i++) {
        [values addObject:@(0.0)];
    }
    //差值
    CGFloat d_value = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger point = 0; point < numOfPoints; point++){
        CGFloat x = (CGFloat)point / (CGFloat)numOfPoints;
        //1 y = 1-e^{-5x} * cos(30x)
        CGFloat value = [toValue floatValue] - d_value * (pow(M_E, -damping * x) * cos(velocity * x));
        values[point] = @(value);
    }
    
    return values;
}

+(CAKeyframeAnimation *)createSpring:(NSString *)keypath duration:(CFTimeInterval)duration usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity fromValue:(id)fromValue toValue:(id)toValue{
    CGFloat dampingFactor = 10;
    CGFloat velocityFactor = 10;
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    NSMutableArray *values = [TXSpringAnimation animationValues:fromValue toValue:toValue usingSpringWithDamping:damping * dampingFactor initialSpringVelocity:velocity * velocityFactor duration:duration];
    anim.values = values;
    anim.duration = duration;
    return anim;
}

@end
