//
//  TXFontViewController.m
//  HelloWorld
//
//  Created by ken on 2018/5/17.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXFontViewController.h"

@interface TXFontViewController ()

@end

@implementation TXFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *text = [[UITextField alloc] init];
    text.backgroundColor = [UIColor blueColor];
    [self.view addSubview:text];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 60));
    }];
    
    NSArray *array = [UIFont familyNames];
    for (NSString *name in array) {
        NSLog(@"name = %@", name);
        NSArray *fontNames = [UIFont fontNamesForFamilyName:name];
        for (NSString *fontName in fontNames) {
            NSLog(@"fontName = %@", fontName);
        }
    }
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
