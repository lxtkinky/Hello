//
//  TXBezierLayer.m
//  HelloWorld
//
//  Created by ken on 2018/5/18.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXBezierLayer.h"
#import "TXSpringAnimation.h"

@implementation TXBezierLayer

- (instancetype)initWithLayer:(TXBezierLayer *)layer{
    self = [super initWithLayer:layer];
    if (self) {
        self.factor = layer.factor;
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key{
    if ([key isEqualToString:@"factor"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)addAnimation{
//    CAKeyframeAnimation *animation = [TXSpringAnimation createSpring:@"factor" duration:0.8 usingSpringWithDamping:0.5 initialSpringVelocity:3 fromValue:@(0) toValue:@(1)];
    /*
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"factor"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i < 100; i++) {
        CGFloat value = i / 100.0f;
        [array addObject:@(value)];
    }
    [array addObjectsFromArray:[[array reverseObjectEnumerator] allObjects]];
    animation.duration = 3;
    animation.values = array;
    [self addAnimation:animation forKey:@"restoreAnimation"];
    */
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(40, 40)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 40)];
    animation.duration = 3;
    animation.autoreverses = NO;
    //下面两个属性联合使用动画结束后会保持结束的状态
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self addAnimation:animation forKey:@"remove"];
    
    /*
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"factor"];
    animation.fromValue = @(1);
    animation.toValue = @(0);
    animation.mass = 1;     //默认是1 必须大于0 对象质量 质量越大 弹性越大 需要的动画时间越长
    animation.stiffness = 100;  //必须大于0  默认是100 刚度系数，刚度系数越大，产生形变的力就越大，运动越快
    animation.damping = 2;     //默认是10 必须大于或者等于0 阻尼系数 阻止弹簧伸缩的系数 阻尼系数越大，停止越快。时间越短
    animation.initialVelocity = 2;      //默认是0 初始速度，正负代表方向，数值代表大小
    animation.duration = animation.settlingDuration;    //计算从开始到结束的动画的时间，根据当前的参数估算时间
    [self addAnimation:animation forKey:@"restoreAnimation"];
     */
}

- (void)drawInContext:(CGContextRef)ctx{
    NSLog(@"factor = %f", _factor);
    CGRect rect = self.bounds;
    CGFloat maxExtra = rect.size.width * 0.2;
    CGFloat extra = maxExtra * _factor;
    CGFloat offset = rect.size.width / 3.6;
    CGPoint pointA = CGPointMake(rect.size.width * 0.5, rect.origin.y + extra);
    CGPoint pointB = CGPointMake(rect.size.width, rect.size.height * 0.5);
    CGPoint pointC = CGPointMake(rect.size.width * 0.5, rect.size.height - extra);
    CGPoint pointD = CGPointMake(rect.origin.x, rect.size.height * 0.5);
    
    CGPoint c1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, pointB.y - offset);
    CGPoint c3 = CGPointMake(pointB.x, pointB.y + offset);
    CGPoint c4 = CGPointMake(pointC.x + offset, pointC.y);
    CGPoint c5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, pointD.y + offset);
    CGPoint c7 = CGPointMake(pointD.x, pointD.y - offset);
    CGPoint c8 = CGPointMake(pointA.x - offset, pointA.y);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:pointA];
    [bezierPath addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [bezierPath addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [bezierPath addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [bezierPath addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [bezierPath closePath];
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, bezierPath.CGPath);
    //    [RGBCOLOR(arc4random() % 255, arc4random() % 255, arc4random() % 255) set];
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);
}


@end
