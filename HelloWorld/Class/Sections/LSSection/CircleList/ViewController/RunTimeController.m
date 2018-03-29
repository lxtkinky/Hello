//
//  RunTimeController.m
//  HelloWorld
//
//  Created by lixt on 2018/2/8.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "RunTimeController.h"
#import <objc/message.h>

@interface RunTimeController ()

@end

@implementation RunTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    objc_msgSend(self, sel_registerName("test"));
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)test{
    NSLog(@"objc_msgSend");
}

//void test(){
//    NSLog(@"objc_msgSend");
//}

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
