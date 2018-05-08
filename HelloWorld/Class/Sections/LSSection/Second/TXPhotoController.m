//
//  TXPhotoController.m
//  HelloWorld
//
//  Created by ken on 2018/5/7.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXPhotoController.h"

@interface TXPhotoController ()

@end

@implementation TXPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"相册" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [self openPhoto];
        [self openWechat];
    }];
}

- (void)openWechat{
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    if (canOpen) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
    }
    else{
        NSLog(@"无法打开微信");
    }
    
}

- (void)openPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
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
