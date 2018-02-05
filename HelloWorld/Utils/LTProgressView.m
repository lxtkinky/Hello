//
//  LTProgressView.m
//  HelloWorld
//
//  Created by test on 2018/1/2.
//  Copyright © 2018年 test. All rights reserved.
//

#import "LTProgressView.h"

@implementation LTProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UILabel *)progressLabel
{
    if (_progressLabel == nil) {
        
        CGFloat w = self.bounds.size.width;
        CGFloat h = self.bounds.size.height;
        
        UILabel *label = [[UILabel alloc] init];
        label.center = CGPointMake(w * 0.5, h * 0.5);
        label.bounds = CGRectMake(0, 0, w, 30);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        _progressLabel = label;
    }
    
    return _progressLabel;
}

//progress的setter方法
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    self.progressLabel.text = [NSString stringWithFormat:@"%.2f%%", progress * 100];
    
    //重绘, 会调用drawRect:rect的方法
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    //圆点
    CGPoint center = CGPointMake(w * 0.5, h * 0.5);
    //半径
    CGFloat radius = w * 0.5 - 5;
    //起点角度: 以x轴正方向所在位置为0
    CGFloat startA = -M_PI_2;
    //终点角度
    CGFloat endA = -M_PI_2 + _progress * 2 * M_PI;
    
    //arc:弧
    //clockwise : 顺时针
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    //设置笔触的颜色
    [[UIColor blueColor] set];
    
    //设置笔触宽度为5px
    CGContextSetLineWidth(ctx, 5);
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}

@end
