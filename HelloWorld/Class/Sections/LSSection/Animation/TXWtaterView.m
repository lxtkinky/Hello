//
//  TXWtaterView.m
//  HelloWorld
//
//  Created by ken on 2018/5/18.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXWtaterView.h"

@implementation TXWtaterView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 创建一个贝塞尔曲线句柄
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 初始化该path到一个初始点
    
    [path moveToPoint:CGPointMake(0, 0)];
    
    //    // 添加一条直线
    
    //    [path addLineToPoint:CGPointMake(0, 0)];
    
    // 画二元曲线，一般和moveToPoint配合使用
    
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width, 0) controlPoint:CGPointMake(self.frame.size.width/2,- _offsetY*1.2)];
    
    // 关闭该path
    
    [path closePath];
    
    // 创建描边（Quartz）上下文
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 将此path添加到Quartz上下文中
    
    CGContextAddPath(context, path.CGPath);
    
    // 设置本身颜色
    
    [[UIColor redColor] set];
    
    // 设置填充的路径
    
    CGContextFillPath(context);
}


@end
