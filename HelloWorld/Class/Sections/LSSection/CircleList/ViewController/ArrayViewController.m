//
//  ArrayViewController.m
//  HelloWorld
//
//  Created by lixt on 2018/4/12.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "ArrayViewController.h"

@interface ArrayViewController ()

@end

@implementation ArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"124566"];
    [array addObject:@"124566"];
    [array addObject:@"124566"];
    NSArray *initArray = [NSArray arrayWithArray:array];
    NSArray *initCopyArray = [initArray copy];
    NSArray *initMutlCopyArray = [initArray mutableCopy];
    NSObject *copyArray = [array copy];
    NSObject *mutlCopyArray = [array mutableCopy];
    NSLog(@"======================");
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
