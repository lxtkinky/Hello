//
//  LXTCalenderView.m
//  HelloWorld
//
//  Created by test on 2018/1/15.
//  Copyright © 2018年 test. All rights reserved.
//

#import "LXTCalenderView.h"
#import "LXTWeekMenuView.h"

@implementation LXTCalenderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.calendarView];
    [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(40);
    }];
}

- (JTHorizontalCalendarView *)calendarView{
    if (!_calendarView) {
        _calendarView = [[JTHorizontalCalendarView alloc] init];
    }
    return _calendarView;
}

@end
