//
//  TXInstallController.m
//  HelloWorld
//
//  Created by ken on 2018/5/23.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXInstallController.h"

@interface TXInstallController ()

@end

@implementation TXInstallController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //首先生成一个plist文件,如SupserGameInfo.plist，该文件必须放在https服务器下面
    
    NSString *urlStr = @"itms-services://?action=download-manifest&url=https://raw.githubusercontent.com/lxtkinky/BaseDemo/master/BaseDemo/Class/Helpers/SupserGameInfo.plist";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
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
