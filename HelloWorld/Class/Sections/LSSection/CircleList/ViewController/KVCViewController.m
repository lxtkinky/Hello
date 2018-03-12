//
//  KVCViewController.m
//  HelloWorld
//
//  Created by ken on 2018/3/1.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "KVCViewController.h"
#import "KVCModel.h"

@interface KVCViewController ()

@end

@implementation KVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KVCModel *model = [[KVCModel alloc] init];
    [model setValue:@"lixt" forKey:@"name"];
    NSObject *name = [model valueForKey:@"name"];
    NSLog(@"model.name = %@", name);
    
    [model setValue:nil forKey:@"age"];
    [model setValue:nil forKey:@"address"];
    [model valueForKey:@"address"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
