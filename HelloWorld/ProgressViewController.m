//
//  ProgressViewController.m
//  HelloWorld
//
//  Created by test on 2018/1/2.
//  Copyright © 2018年 test. All rights reserved.
//

#import "ProgressViewController.h"
#import "LTProgressView.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

@interface ProgressViewController ()

@property (nonatomic, strong) UIButton *showButton;
@property (nonatomic, strong) UIButton *dismissButton;

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    UIProgressView *progressView = [[UIProgressView alloc] init];
//    progressView.progress = 0.3;
//    progressView.progressTintColor = [UIColor greenColor];
//    progressView.trackTintColor = [UIColor redColor];
//    [self.view addSubview:progressView];
//    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(300, 5));
//    }];
    
//    [SVProgressHUD show];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.showButton];
    [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(40);
        make.bottom.equalTo(self.view).with.offset(-100);
        make.height.mas_equalTo(60);
    }];
    
    [self.view addSubview:self.dismissButton];
    [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-40);
        make.left.equalTo(self.showButton.mas_right).with.offset(40);
        make.size.equalTo(self.showButton);
        make.centerY.equalTo(self.showButton);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)showButton{
    if (!_showButton) {
        _showButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showButton setTitle:@"show" forState:UIControlStateNormal];
        _showButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            [SVProgressHUD show];
            return [RACSignal empty];
        }];
    }
    
    return _showButton;
}

- (UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissButton setTitle:@"dismiss" forState:UIControlStateNormal];
        _dismissButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            [SVProgressHUD dismiss];
            return [RACSignal empty];
        }];
    }
    return _dismissButton;
}

@end
