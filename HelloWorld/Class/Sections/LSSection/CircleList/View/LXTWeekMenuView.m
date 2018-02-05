//
//  LXTWeekMenuView.m
//  HelloWorld
//
//  Created by test on 2018/1/15.
//  Copyright © 2018年 test. All rights reserved.
//

#import "LXTWeekMenuView.h"

@implementation LXTWeekMenuView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    NSArray *titleArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    NSMutableArray *labelArray = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [titleArray objectAtIndex:i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:PingFang_SC_Medium size:14.0];
        label.textAlignment = NSTextAlignmentCenter;
        [labelArray addObject:label];
        [self addSubview:label];
    }
    
    for (int i = 0; i < labelArray.count; i++) {
        UILabel *label = [labelArray objectAtIndex:i];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(self);
            }
            else{
                UILabel *prevLabel = [labelArray objectAtIndex:i - 1];
                make.left.equalTo(prevLabel.mas_right);
                make.width.equalTo(prevLabel);
            }
            
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            
            if (i == labelArray.count - 1) {
                make.right.equalTo(self);
            }
            
            
        }];
    }
}

@end
