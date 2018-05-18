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

@interface TXAnimationController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *nickNameView;

@property (nonatomic, strong) TXWtaterView *waterView;
@property (nonatomic, strong) TXBallView *ball;
@property (nonatomic, strong) UIView *springView;

@end

@implementation TXAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addBallView];
    
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
}

#pragma mark - 阻尼运动
- (void)addSpringLayerView{
    UIView *springView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 60, 60)];
    self.springView = springView;
    springView.backgroundColor = [UIColor blueColor];
    TXBezierLayer *layer = [[TXBezierLayer alloc] init];
    layer.bounds = springView.bounds;
    layer.position = CGPointMake(30, 30);
    [layer addAnimation];
    [springView.layer addSublayer:layer];
    [layer setNeedsDisplay];
    [self.view addSubview:springView];
}


#pragma mark - 小球滑动
- (void)addBallView{
    UISlider *slider = [[UISlider alloc] init];
    [slider addTarget:self action:@selector(ballSliderValueChange:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:slider];
    slider.center = self.view.center;
    
    TXBallView *ball = [[TXBallView alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
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
