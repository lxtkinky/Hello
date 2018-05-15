//
//  TXWebSocketController.m
//  HelloWorld
//
//  Created by ken on 2018/5/9.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXWebSocketController.h"
#import "TXWebSocketManager.h"

@interface TXWebSocketController ()

@property (nonatomic, strong) TXWebSocketManager *manager;

@end

@implementation TXWebSocketController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"连接socket" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self testSocket];
    }];
}

- (void)testSocket{
    NSString *str = @"123";
    NSString *str1 = @"123";
    NSLog(@"%p", str);
    NSLog(@"%p", str1);
    
    
    WS(weakSelf)
    TXWebSocketManager *manager = [TXWebSocketManager socketManager];
    self.manager = manager;
    manager.socketOpenBlock = ^{
        NSLog(@"连接成功！");
        NSString *message = @"{\"command\":\"join\",\"group\":\"quiz_123\"}";
        [weakSelf.manager sendMessage:message];
        
        NSString *msg = @"{\"command\":\"send\",\"group\":\"quiz_123\",\"message\":\"ssssss\"}";
        [weakSelf.manager sendMessage:msg];
    };
    
   
    manager.socketFailBlock = ^(NSError *error){
        NSLog(@"连接失败！  %@", error);
    };
    
    manager.socketRecBlock = ^(id message){
        NSLog(@"接收数据！= %@", message);
    };
    
    [manager openSocketWithURLString:@"ws://192.168.2.100:8000/quiz/?"];
}


- (void)testSocket2{
    WS(weakSelf)
    TXWebSocketManager *manager = [TXWebSocketManager socketManager];
//    self.manager = manager;
    manager.socketOpenBlock = ^{
        NSLog(@"连接成功！");
        NSString *message = @"{\"command\":\"join\",\"group\":\"quiz_123\"}";
        [weakSelf.manager sendMessage:message];
        
        NSString *msg = @"{\"command\":\"send\",\"group\":\"quiz_123\",\"message\":\"ssssss\"}";
        [weakSelf.manager sendMessage:msg];
    };
    
    
    manager.socketFailBlock = ^(NSError *error){
        NSLog(@"连接失败！  %@", error);
    };
    
    manager.socketRecBlock = ^(id message){
        NSLog(@"接收数据！= %@", message);
    };
    
    [manager openSocketWithURLString:@"ws://192.168.2.100:8000/quiz/?"];
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
