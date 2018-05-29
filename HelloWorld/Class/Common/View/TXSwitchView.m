//
//  TXSwitchView.m
//  HelloWorld
//
//  Created by ken on 2018/5/21.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXSwitchView.h"

#define enableColor UIColorFromRGB(0x3698ab)
#define disableColor UIColorFromRGB(0x79888c)
#define btnColor UIColorFromRGB(0x3b93a9)

@interface TXSwitchView()<CAAnimationDelegate>

@property (nonatomic) BOOL switchOn;
@property (nonatomic, strong) CALayer *aniLayer;
@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation TXSwitchView

- (instancetype)initWithFrame:(CGRect)frame switchOn:(BOOL)switchOn{
    self = [self initWithFrame:frame];
    self.switchOn = switchOn;
    [self initAnimationLayer];
    [self initGesture];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initAnimationLayer{
//    self.layer.cornerRadius = self.frame.size.height * 0.5;
//    self.clipsToBounds = YES;
    
    self.colorLayer = [[CALayer alloc] init];
    self.colorLayer.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.colorLayer.cornerRadius = self.frame.size.height * 0.5;
    self.colorLayer.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    [self.layer addSublayer:self.colorLayer];
    if (_switchOn) {
        self.colorLayer.backgroundColor = enableColor.CGColor;
    }
    else{
        self.colorLayer.backgroundColor = disableColor.CGColor;
    }
    
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, self.frame.size.height + 2, self.frame.size.height + 2);
    layer.cornerRadius = self.frame.size.height * 0.5 + 1;
    if (_switchOn) {
        layer.position = CGPointMake( self.frame.size.width - self.frame.size.height * 0.5,  self.frame.size.height * 0.5);
    }
    else{
        layer.position = CGPointMake(self.frame.size.height * 0.5, self.frame.size.height * 0.5);
    }
    layer.backgroundColor = btnColor.CGColor;
    self.aniLayer = layer;
    [self.layer addSublayer:layer];
}

- (void)initGesture{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewEvent:)];
    [self addGestureRecognizer:gesture];
}

- (void)tapViewEvent:(UITapGestureRecognizer *)gesture{
    if (_switchOn) {
        _switchOn = NO;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.fromValue = @(CGPointMake(self.frame.size.width - self.frame.size.height * 0.5 + 1, self.frame.size.height * 0.5));
        animation.toValue = @(CGPointMake(self.frame.size.height * 0.5 - 1, self.frame.size.height * 0.5));
        animation.duration = 0.25;
        animation.autoreverses = NO;
        //下面两个属性联合使用动画结束后会保持结束的状态
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.delegate = self;
        [self.aniLayer addAnimation:animation forKey:@"MoveLeft"];
    }
    else{
        _switchOn = YES;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.fromValue = @(CGPointMake(self.frame.size.height * 0.5 + 1, self.frame.size.height * 0.5));
        animation.toValue = @(CGPointMake(self.frame.size.width - self.frame.size.height * 0.5 - 1, self.frame.size.height * 0.5));
        animation.duration = 0.25;
        animation.autoreverses = NO;
        //下面两个属性联合使用动画结束后会保持结束的状态
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.delegate = self;
        [self.aniLayer addAnimation:animation forKey:@"MoveRight"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (_switchOn) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        animation.fromValue = (id)disableColor.CGColor;
        animation.toValue = (id)enableColor.CGColor;
        animation.duration = 0.3;
        animation.autoreverses = NO;
        //下面两个属性联合使用动画结束后会保持结束的状态
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.colorLayer addAnimation:animation forKey:@"ColorGreen"];
    }
    else{
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        animation.fromValue = (id)enableColor.CGColor;
        animation.toValue = (id)disableColor.CGColor;
        animation.duration = 0.3;
        animation.autoreverses = NO;
        //下面两个属性联合使用动画结束后会保持结束的状态
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.colorLayer addAnimation:animation forKey:@"ColorGray"];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
