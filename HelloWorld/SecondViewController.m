//
//  SecondViewController.m
//  HelloWorld
//
//  Created by test on 17/12/19.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SecondViewController.h"
#import "Masonry.h"

@interface SecondViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = UITextAlignmentLeft;
    
//    [_delegateSubject sendNext:@"hello"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints{
//    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(50);
//    }];
    
    [super updateViewConstraints];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark getter setter

- (UIButton *)button{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor greenColor];
        [_button setTitle:@"load" forState:UIControlStateNormal];
        _button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            NSLog(@"%@", input);
            [self.delegateSubject sendNext:@"hello"];
//            //验证在子线程中更新UI
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                //会立即更新UI
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.button setTitle:@"load ended" forState:UIControlStateNormal];
//                    
//                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//                    button.backgroundColor = [UIColor redColor];
//                    [self.view addSubview:button];
//                    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.size.equalTo(_button);
//                        make.centerX.equalTo(_button);
//                        make.top.equalTo(_button.mas_bottom).with.offset(20);
//                    }];
//                });
//                
//                sleep(10);
//                
//                NSLog(@"sleep over");
//            });
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [self.button setTitle:@"load ended" forState:UIControlStateNormal];   //可以更新 ？
//                //添加按钮会等到线程结束后才更新
//                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//                button.backgroundColor = [UIColor redColor];
//                [self.view addSubview:button];
//                [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.size.equalTo(_button);
//                    make.centerX.equalTo(_button);
//                    make.top.equalTo(_button.mas_bottom).with.offset(20);
//                }];
//                sleep(10);
//            });
            return [RACSignal empty];
        }];
    }
    
    return _button;
}


@end
