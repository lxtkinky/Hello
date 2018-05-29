//
//  TXAnimationController.m
//  HelloWorld
//
//  Created by ken on 2018/5/17.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXAnimationController.h"
#import "TXWtaterView.h"
#import "TXBallView.h"
#import "TXSpringAnimation.h"
#import "TXBezierLayer.h"
#import "TXSpringAnimation.h"
#import "TXSwitchView.h"

@interface TXAnimationController ()<UIScrollViewDelegate,CAAnimationDelegate>

@property (nonatomic, strong) UIView *nickNameView;

@property (nonatomic, strong) TXWtaterView *waterView;
@property (nonatomic, strong) TXBallView *ball;
@property (nonatomic, strong) UIView *springView;

@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation TXAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBallView];
    
    [self tx_addSwitchView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"开始动画" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self addSpringLayerView];
    }];
    
    [self downloadApp];
}

- (void)downloadApp{
    NSString *urlStr = @"itms-services://?action=download-manifest&url=https://raw.githubusercontent.com/lxtkinky/BaseDemo/master/BaseDemo/Class/Helpers/SupserGameInfo.plist";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

- (void)tx_addSwitchView{
    TXSwitchView *switchView = [[TXSwitchView alloc] initWithFrame:CGRectMake(20, 300, 60, 30) switchOn:YES];
    [self.view addSubview:switchView];
    
    TXSwitchView *switchOff = [[TXSwitchView alloc] initWithFrame:CGRectMake(20, 400, 60, 30) switchOn:NO];
    [self.view addSubview:switchOff];
}

#pragma mark - 组动画
- (void)groupAnimation{
    UIView *circleView = [[UIView alloc] init];
    circleView.backgroundColor = [UIColor redColor];
    circleView.frame = CGRectMake(0, 200, 40, 40);
    [self.view addSubview:circleView];
    
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:anima1,anima2,anima3, nil];
    groupAnimation.duration = 4.0f;
    [circleView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

#pragma mark - 圆形轨迹运动
- (void)circleAnimation{
    UIView *circleView = [[UIView alloc] init];
    circleView.backgroundColor = [UIColor redColor];
    circleView.frame = CGRectMake(0, 200, 40, 40);
    [self.view addSubview:circleView];
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
    anima.path = path.CGPath;
    anima.duration = 2.0f;
    [circleView.layer addAnimation:anima forKey:@"pathAnimation"];
}

#pragma mark - 阻尼运动
- (void)addSpringLayerView{
    UIView *springView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 60, 30)];
    springView.layer.cornerRadius = 15.0;
    self.springView = springView;
    springView.backgroundColor = [UIColor blueColor];
    TXBezierLayer *layer = [[TXBezierLayer alloc] init];
    layer.bounds = CGRectMake(0, 0, 30, 30);
    layer.position = CGPointMake(15, 15);
//    layer.backgroundColor = [UIColor redColor].CGColor;
//    [layer addAnimation];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    self.animation = animation;
    animation.delegate = self;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(15, 15)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(45, 15)];
    animation.duration = 0.3;
    animation.autoreverses = NO;
    //下面两个属性联合使用动画结束后会保持结束的状态
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:@"remove"];
    [springView.layer addSublayer:layer];
    [layer setNeedsDisplay];
    [self.view addSubview:springView];
}

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"start");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.springView.backgroundColor = [UIColor grayColor];
}


#pragma mark - 小球滑动
- (void)addBallView{
    UISlider *slider = [[UISlider alloc] init];
    [slider addTarget:self action:@selector(ballSliderValueChange:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:slider];
    slider.center = self.view.center;
    
    TXBallView *ball = [[TXBallView alloc] initWithFrame:CGRectMake(20, 200, 100, 30)];
    ball.backgroundColor = [UIColor clearColor];
    self.ball = ball;
//    self.ball.factor = 0;
    [self.view addSubview:ball];
    
}

- (void)ballSliderValueChange:(UISlider *)slider{
    self.ball.factor = slider.value;
    self.ball.center = CGPointMake(45 + slider.value * 300, self.ball.center.y);
    [self.ball setNeedsDisplay];
}

#pragma mark - 下拉水滴效果
- (void)addWaterView{
    self.waterView = [[TXWtaterView alloc] init];
    self.waterView.backgroundColor = [UIColor blueColor];
    self.waterView.frame = CGRectMake(0, 64, kMainScreenWidth, 200);
//    self.waterView.offsetY = -200;
    [self.view addSubview:self.waterView];
    
    UISlider *slider = [[UISlider alloc] init];
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:slider];
    slider.center = self.view.center;
}

- (void)sliderValueChange:(UISlider *)slider{
    self.waterView.offsetY = slider.value * -200;
    [self.waterView setNeedsDisplay];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetY = %.2f", offsetY);
    self.waterView.offsetY = offsetY;
    
    [self.waterView setNeedsDisplay];
}

#pragma mark - 回弹动画
- (void)addSpringView{
    self.nickNameView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.nickNameView.backgroundColor = [UIColor blueColor];
    self.nickNameView.center = self.view.center;
    [self.view addSubview:self.nickNameView];
    
    WS(weakSelf)
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"开始动画" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    
    [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf springAnimation];
    }];
}

- (void)springAnimation{
    self.nickNameView.layer.transform = CATransform3DMakeScale(0.6, 0.6, 0.6);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:(UIViewAnimationOptionTransitionNone) animations:^{
        self.nickNameView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"dealloc");
}



@end
