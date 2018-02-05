//
//  CalendarController.m
//  HelloWorld
//
//  Created by test on 2018/1/15.
//  Copyright © 2018年 test. All rights reserved.
//

#import "CalendarController.h"
#import "JTCalendar.h"
#import "LXTCalenderView.h"
#import "LXTWeekMenuView.h"

@interface CalendarController ()<JTCalendarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JTCalendarManager *calendarManager;
@property (nonatomic, strong) JTCalendarMenuView *menuView;
@property (nonatomic, strong) JTHorizontalCalendarView *calendarView;
@property (nonatomic, strong) LXTCalenderView *lxtCalendarView;

@property (nonatomic, strong) JTCalendarManager *weekManager;
@property (nonatomic, strong) JTHorizontalCalendarView *weekView;
@property (nonatomic, strong) LXTCalenderView *lxtWeekView;
@property (nonatomic, strong) NSDate *dateSelected;
@property (nonatomic) CGFloat showHiddenViewY;



@property (nonatomic, strong) UITableView *tableView;

@end

static CGFloat lineH = 40;
@implementation CalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGRect statusFrame = [UIApplication sharedApplication].statusBarFrame;
    CGFloat topMargin = statusFrame.size.height + 44;
    
    
    self.calendarManager.delegate = self;
    _calendarView = self.lxtCalendarView.calendarView;
    [self.calendarManager setContentView:self.lxtCalendarView.calendarView];
    _dateSelected = [NSDate date];
    [self.calendarManager setDate:_dateSelected];
    [self testData:nil];
    
    
    self.weekManager.delegate = self;
    self.weekView = self.lxtWeekView.calendarView;
    [self.weekManager setContentView:self.lxtWeekView.calendarView];
    [self.weekManager setDate:_dateSelected];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(topMargin, 0, 0, 0 ));
    }];
    
    [self.view addSubview:self.lxtWeekView];
    [self.lxtWeekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(topMargin);
        make.height.mas_equalTo(lineH * 2);
    }];
    

    
    LXTWeekMenuView *view = [[LXTWeekMenuView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(topMargin);
        make.height.mas_equalTo(lineH);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testData:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *beginDate = nil;
    double interval = 0;
    [calendar setFirstWeekday:2];
    NSDateComponents *coms = nil;
    NSInteger calendarFlag = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    BOOL result = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:_dateSelected];
    if (result) {
        NSLog(@"beginDate==%@", beginDate);
        coms = [calendar components:calendarFlag fromDate:beginDate];
        NSInteger weekday = [coms weekday] - 1;
        NSDateComponents *comps = [calendar components:calendarFlag fromDate:_dateSelected];
        NSInteger day = [comps day];
        float line = ceil((day - (7 - weekday) ) / 7.0) + 1;
        self.showHiddenViewY = lineH * (line - 1);
        NSLog(@"weekday == %ld, day == %ld", weekday, day);
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return lineH * 7;
    }
    
    return 50;
}

static NSString *cell1 = @"cell1";
static NSString *cell2= @"cell2";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:cell1];
        if (cell.contentView.subviews.count == 0) {
            [cell.contentView addSubview:self.lxtCalendarView];
            [self.lxtCalendarView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
        }
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:cell2];
        cell.backgroundColor = RGBCOLOR(arc4random() % 100 + 100, arc4random() % 100 + 100, arc4random() % 100 + 100);
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"contentOffsetY-%.0f", scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y > _showHiddenViewY) {
        self.lxtWeekView.hidden = NO;
    }
    else{
        self.lxtWeekView.hidden = YES;
    }
}

#pragma mark - JTCalendarDelegate
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(UIView<JTCalendarDay> *)dayView{
    JTCalendarDayView *tmp = (JTCalendarDayView *)dayView;
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        tmp.circleView.hidden = NO;
        tmp.circleView.backgroundColor = [UIColor blueColor];
        tmp.dotView.backgroundColor = [UIColor whiteColor];
        tmp.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        tmp.circleView.hidden = NO;
        tmp.circleView.backgroundColor = [UIColor redColor];
        tmp.dotView.backgroundColor = [UIColor whiteColor];
        tmp.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarView.date isTheSameMonthThan:dayView.date]){
        tmp.circleView.hidden = YES;
        tmp.dotView.backgroundColor = [UIColor redColor];
        tmp.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        tmp.circleView.hidden = YES;
        tmp.dotView.backgroundColor = [UIColor redColor];
        tmp.textLabel.textColor = [UIColor blackColor];
    }
    
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    if(![_calendarManager.dateHelper date:_calendarView.date isTheSameMonthThan:dayView.date]){
        return;
    }
    _dateSelected = dayView.date;
    
    [self testData:_dateSelected];
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                        [_weekManager setDate:_dateSelected];
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
//    if(_calendarManager.settings.weekModeEnabled){
//        return;
//    }
    
    // Load the previous or next page if touch a day from another month
    
//    if(![_calendarManager.dateHelper date:_calendarView.date isTheSameMonthThan:dayView.date]){
//        if([_calendarView.date compare:dayView.date] == NSOrderedAscending){
//            [_calendarView loadNextPageWithAnimation];
//        }
//        else{
//            [_calendarView loadPreviousPageWithAnimation];
//        }
//    }
}



- (JTCalendarManager *)calendarManager{
    if (!_calendarManager) {
        _calendarManager = [JTCalendarManager new];
    }
    return _calendarManager;
}

- (JTCalendarMenuView *)menuView{
    if (!_menuView) {
        _menuView = [[JTCalendarMenuView alloc] init];
        _menuView.backgroundColor = RGBCOLOR(201, 102, 303);
    }
    return _menuView;
}

- (JTHorizontalCalendarView *)calendarView{
    if (!_calendarView) {
        _calendarView = [[JTHorizontalCalendarView alloc] init];
        _calendarView.backgroundColor = RGBCOLOR(45, 65, 88);
    }
    return _calendarView;
}
- (JTCalendarManager *)weekManager{
    if (!_weekManager) {
        _weekManager = [JTCalendarManager new];
        _weekManager.settings.weekModeEnabled = YES;
    }
    return _weekManager;
}

- (JTHorizontalCalendarView *)weekView{
    if (!_weekView) {
        _weekView = [[JTHorizontalCalendarView alloc] init];
        _weekView.backgroundColor = RGBCOLOR(222, 111, 123);
    }
    return _weekView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell1];
         [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell2];
    }
    return _tableView;
}

- (LXTCalenderView *)lxtCalendarView{
    if (!_lxtCalendarView) {
        _lxtCalendarView = [[LXTCalenderView alloc] init];
    }
    
    return _lxtCalendarView;
}

- (LXTCalenderView *)lxtWeekView{
    if (!_lxtWeekView) {
        _lxtWeekView = [[LXTCalenderView alloc] init];
        _lxtWeekView.hidden = YES;
    }
    
    return _lxtWeekView;
}

@end
