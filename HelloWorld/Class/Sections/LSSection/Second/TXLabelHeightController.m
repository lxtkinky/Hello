//
//  TXLabelHeightController.m
//  HelloWorld
//
//  Created by ken on 2018/5/15.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXLabelHeightController.h"
#import "NSString+Helper.h"

@interface TXLabelHeightController ()

@end

@implementation TXLabelHeightController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
    label.numberOfLines = 0;
    NSString *str = @"水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生水电费了水电费是否落实领导发生";
    label.text = str;
    UIFont *font = [UIFont systemFontOfSize:14.0];
    label.font = font;
    CGFloat height = [str getHeightWithWidth:200 font:font];
    NSLog(@"height = %.2f", height);
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(200);
    }];
    
    
    UIView *backView = [[UIView alloc] init];
    [self.view addSubview:backView];
    backView.backgroundColor = [UIColor redColor];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(height);
    }];
    
    [self.view bringSubviewToFront:label];
}

- (CGFloat)getHeightWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    NSDictionary *dict = @{NSFontAttributeName : font, NSParagraphStyleAttributeName : style};
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    return height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
