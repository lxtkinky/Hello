//
//  TXPrizeView.m
//  HelloWorld
//
//  Created by ken on 2018/5/28.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXPrizeView.h"
#import "TXStartPrizeView.h"
#import "TXDiscView.h"
#import "TXGifView.h"

@interface TXPrizeView()<CAAnimationDelegate>

@property (nonatomic, strong) TXGifView *gifView;
@property (nonatomic, strong) TXStartPrizeView *startView;
@property (nonatomic, strong) TXDiscView *discView;
@property (nonatomic, strong) UIImageView *pointerImageV;

@property (nonatomic) CGFloat currentPoint; //当前转盘位置

@property (nonatomic) NSInteger testInt;


@property (nonatomic) BOOL started;

@end

@implementation TXPrizeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self tx_initSubview:frame];
        [self tx_bindViewModel];
    }
    return self;
}

- (void)tx_initSubview:(CGRect)frame{
    self.gifView = [[TXGifView alloc] initWithGif:@"turntable"];
    self.gifView.frame = CGRectMake(0, 0, 362, 362);
    self.gifView.center = self.center;
    [self addSubview:self.gifView];
    
    self.discView = [TXDiscView discViewWithFrame:CGRectMake(0, 0, 375, 375 )];
    self.discView.center = self.center;
    [self addSubview:self.discView];
    
    self.startView = [TXStartPrizeView startPrizeView];
    self.startView.frame = CGRectMake(0, 0, 113, 113);
    self.startView.center = self.center;
    [self addSubview:self.startView];
    
    self.pointerImageV = [[UIImageView alloc] init];
    self.pointerImageV.image = [UIImage imageNamed:@"turntable_v"];
    [self addSubview:self.pointerImageV];
    self.pointerImageV.frame = CGRectMake(0, 0, 59, 81);
    self.pointerImageV.center = CGPointMake(self.center.x, 42);
    
}

- (void)tx_bindViewModel{
    WS(weakSelf)
    [self.startView.startSubject subscribeNext:^(id  _Nullable x) {
        if (weakSelf.started) {
            return ;
        }
        weakSelf.started = YES;
        [weakSelf.gifView startGif];
        [weakSelf discViewStartAnimate];
    }];
    
//    self.currentPoint = M_PI_4 * 0.5;
    
}

/**
 * a为加速度，v为初始速度，v0为末速度，x为位移
 * a = v*v - v0*v0 / (2 * x)
 * x = v*t + 1/2 * a * t * t;
 */
- (void)discViewStartAnimate{
    NSMutableArray *pointArray = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        NSNumber *point = [NSNumber numberWithFloat:M_PI_4 * 0.5 + i * M_PI_4];
        [pointArray addObject: point];
    }
    
    _prizePoint = [[pointArray objectAtIndex: _testInt++ % 8] floatValue];
    float mod = fmod(_currentPoint, 2 * M_PI);
    CGFloat endPoint = _currentPoint + 6 * M_PI + _prizePoint - mod;
    CGFloat durationTime = 4;
    CGFloat speed = (endPoint - _currentPoint) / 2; //初速度
    CGFloat aSpeed = - speed / durationTime;        //加速度
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i <= 60; i++) {
        CGFloat t = (durationTime / 60.0) * i;
        CGFloat x = speed * t + aSpeed * t * t * 0.5 + _currentPoint;
        [array addObject:[NSNumber numberWithFloat:x]];
    }
    animation.values = array;
    animation.duration = durationTime;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [self.discView.layer addAnimation:animation forKey:@"rotation"];
    _currentPoint = endPoint;
    
//    _prizePoint = _prizePoint + M_PI_4;
//    float mod = fmod(_currentPoint, 2 * M_PI);
//    CGFloat endPoint = _currentPoint + 6 * M_PI + _prizePoint - mod;
//    CGFloat durationTime = 4;
//    CGFloat v = endPoint - _currentPoint;
//    CGFloat a = - v / durationTime;
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i <= 60; i++) {
//        CGFloat t = (durationTime / 60.0) * i;
//        CGFloat x = v * t + a * t * t * 0.5 + _currentPoint;
//        [array addObject:[NSNumber numberWithFloat:x]];
//    }
//    animation.values = array;
//    animation.duration = durationTime;
//    animation.autoreverses = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    animation.delegate = self;
//    [self.discView.layer addAnimation:animation forKey:@"rotation"];
//
//    _currentPoint = endPoint;
}

#pragma mark - animation Delegate
- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.started = NO;
    [self.gifView stopGif];
}

@end
