//
//  TXStaticController.m
//  HelloWorld
//
//  Created by HUIDUOLA on 2019/4/1.
//  Copyright © 2019 Sheng Yuan Technology. All rights reserved.
//

#import "TXStaticController.h"

const NSString *testConst = @"test const";
NSString *const testConst2 = @"测试const2";
NSString const *testConst3 = @"测试const3";

@interface TXStaticController ()

@end

@implementation TXStaticController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (int)testStaticFunc{
    NSLog(@"testStaticFunc");
    
    NSString *str = @"author test1";
    NSLog(@"author = %@ => %p", str, str);
    NSString *str2 = @"author test2";
    str = str2;
    NSLog(@"author = %@ => %p", str, str);
    
    NSLog(@"author const变量初始值 = %@ => %p", author, author);
    
//    author = @"lxt";
//    NSLog(@"author 改变const变量的值 = %@ => %p", author, author);
//    
//    author = str2;
//    NSLog(@"author 把str2赋值给const变量 = %@ => %p", author, author);
    
    
    NSLog(@"author = %@ => %p", testConst, testConst);
    testConst = str2;
    NSLog(@"author = %@ => %p", testConst, testConst);

    //不能修改被const修饰的变量  NSString *const testConst2 = @"测试const2";
//    NSLog(@"author = %@ => %p", testConst2, testConst2);
//    testConst2 = @"1234";
//    NSLog(@"author = %@ => %p", testConst2, testConst2);
    
    NSLog(@"author testConst3 = %@ => %p", testConst3, testConst3);
    testConst3 = @"1234";
    NSLog(@"author testConst3 = %@ => %p", testConst3, testConst3);
    testConst3 = str2;
    NSLog(@"author testConst3 = %@ => %p", testConst3, testConst3);
    
    
    
    return 0;
}

@end
