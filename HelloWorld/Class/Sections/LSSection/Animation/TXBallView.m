//
//  TXBallView.m
//  HelloWorld
//
//  Created by ken on 2018/5/18.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXBallView.h"
#import "TXSpringAnimation.h"

@implementation TXBallView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
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
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, bezierPath.CGPath);
//    [RGBCOLOR(arc4random() % 255, arc4random() % 255, arc4random() % 255) set];
    [[UIColor redColor] set];
    CGContextFillPath(context);
}






@end
