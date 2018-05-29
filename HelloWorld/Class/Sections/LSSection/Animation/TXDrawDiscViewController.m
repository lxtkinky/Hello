//
//  TXDrawDiscViewController.m
//  HelloWorld
//
//  Created by ken on 2018/5/26.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXDrawDiscViewController.h"
#import "TXDiscView.h"
#import "CoreTextArcView.h"
#import "TXPrizeView.h"

@interface TXDrawDiscViewController ()

@property (nonatomic, strong) TXDiscView *discView;
@property (nonatomic, strong) TXPrizeView *prizeView;

@property (nonatomic) CGFloat point;

@end

@implementation TXDrawDiscViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat scale = kMainScreenWidth / 375.0;
    if (scale > 1) {
        scale = 1;
    }
    
    TXPrizeView *prizeView = [[TXPrizeView alloc] initWithFrame:CGRectMake(0, 0, 375, 375 + 70)];
//    prizeView.backgroundColor = [UIColor redColor];
    prizeView.center = self.view.center;
    self.prizeView = prizeView;
    [self.view addSubview:prizeView];
    self.prizeView.transform = CGAffineTransformScale(self.prizeView.transform, scale, scale);
    
//    TXDiscView *discView = [TXDiscView discView];
//    discView.frame = CGRectMake(0, 0, 375, 375);
//    discView.center = self.view.center;
//    self.discView = discView;
//    [self.view addSubview:discView];
//    self.discView.transform = CGAffineTransformScale(self.discView.transform, scale, scale);
    
    
    
    
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.image = [UIImage imageNamed:@"turntable_l"];
//    imageView.frame = CGRectMake(0, 0, kMainScreenWidth * 0.8, kMainScreenWidth * 0.8);
//    imageView.center = self.view.center;
//    [self.view addSubview:imageView];
    
    
//    TXDiscView *discView = [[TXDiscView alloc] init];
//    discView.backgroundColor = [UIColor clearColor];
//    self.discView = discView;
//    [self.view addSubview:discView];
//    discView.bounds = CGRectMake(0, 0, kMainScreenWidth * 0.8, kMainScreenWidth * 0.8);
//    discView.center = self.view.center;
    
//    [discView setNeedsDisplay];
    
    WS(weakSelf)
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"停止动画" forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(100, 40));
//    }];
//    [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [weakSelf startAnimation];
//    }];
    
//    CoreTextArcView *arcView = [[CoreTextArcView alloc] initWithFrame:self.discView.bounds
//                                                                 font:[UIFont systemFontOfSize:14.0]
//                                                                 text:@"25 * 积分"
//                                                               radius:kMainScreenWidth * 0.4 - 20
//                                                              arcSize:45
//                                                                color:[UIColor redColor]];
//    [self.discView addSubview:arcView];
//    arcView.backgroundColor = [UIColor clearColor];
    
//    [self splitString];
}

- (void)splitString{
    NSArray *array = @[@"谢谢惠顾", @"再来一次", @"我曹什么鬼", @"hello"];
    
    for (int i = 0; i < array.count; i++) {
        NSString *string = array[i];
        for (int j = 0; j < string.length; j++) {
            NSString *tmpStr = [string substringWithRange:NSMakeRange(j, 1)];
            NSLog(@"tmpStr = %@", tmpStr);
        }
    }
}

- (void)arvTextView{
    UIView *arcBgView = [[UIView alloc] init];
    arcBgView.bounds = CGRectMake(0, 0, 300, 600);
    arcBgView.center = self.view.center;
    arcBgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:arcBgView];
    
    /*
     样就添加了一个弧形文字，效果如下，注意黄色区域为高600宽300，圆弧的中心此时位于黄色区域的正中心，弧度半径为200，略小于高的一半300
     */
    CoreTextArcView *arcView = [[CoreTextArcView alloc] initWithFrame:arcBgView.bounds font:[UIFont systemFontOfSize:20.0] text:@"水电费了水电费" radius:200 arcSize:45 color:[UIColor redColor]];
    arcView.backgroundColor = [UIColor clearColor];
    [arcBgView addSubview:arcView];
}

- (void)startAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
//    animation.fromValue = [NSNumber numberWithFloat:0.f];
//    animation.toValue = [NSNumber numberWithFloat:M_PI];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        CGFloat avg = M_PI / 10.0;
        NSNumber *value = [NSNumber numberWithFloat:avg * i];
        [array addObject:value];
    }
    NSMutableArray *array2 = [NSMutableArray array];
    for (int i = 0; i < 20 ; i++) {
        CGFloat avg = M_PI / 20.0;
        NSNumber *value = [NSNumber numberWithFloat:avg * i - M_PI];
        [array2 addObject:value];
    }
    
    [array2 addObjectsFromArray:array];
    animation.values = array2;
    animation.duration = 4;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.discView.layer addAnimation:animation forKey:@"rotation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
