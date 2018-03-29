//
//  TXGoogleAdController.m
//  HelloWorld
//
//  Created by lixt on 2018/2/5.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXGoogleAdController.h"
#import "TXGoogleAdManager.h"
#import <objc/message.h>

@interface TXGoogleAdController ()

@property (nonatomic, strong) TXGoogleAdManager *manager;

@end

@implementation TXGoogleAdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TXGoogleAdManager *manager = [[TXGoogleAdManager alloc] init];
    self.manager = manager;
    [manager showGoogleAdWithController:self];
    Method method = class_getInstanceMethod(objc_getClass("TXGoogleAdController"), @selector(test:));
    NSLog(@"%s", method_getTypeEncoding(method));
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    
    
}

- (float)test:(NSString *)test{
    return 0.0;
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
