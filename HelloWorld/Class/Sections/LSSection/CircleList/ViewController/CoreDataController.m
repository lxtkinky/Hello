//
//  CoreDataController.m
//  HelloWorld
//
//  Created by test on 2018/1/12.
//  Copyright © 2018年 test. All rights reserved.
//

#import "CoreDataController.h"
//#import "UserEntity.h"

@interface CoreDataController ()

@property (nonatomic, strong) NSManagedObjectModel *managedObjcModel;

@end

@implementation CoreDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectModel *)managedObjcModel{
    if (!_managedObjcModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HelloWorldModel" withExtension:@"momd"];
        
//        _managedObjcModel = [NSManagedObjectModel alloc];
    }
    
    return _managedObjcModel;
}


@end
