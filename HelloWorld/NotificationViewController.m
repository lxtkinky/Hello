//
//  NotificationViewController.m
//  HelloWorld
//
//  Created by test on 2018/1/8.
//  Copyright © 2018年 test. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 80));
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testNotification) name:@"testNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)postNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification" object:nil];
}

- (void)testNotification{
    NSLog(@"%@ post notification", self);
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"post notification" forState:UIControlStateNormal];
        [_button setBackgroundColor:[UIColor yellowColor]];
        WeakType(self)
        _button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            [weakself postNotification];
            return [RACSignal empty];
        }];
    }
    
    return _button;
}
@end
