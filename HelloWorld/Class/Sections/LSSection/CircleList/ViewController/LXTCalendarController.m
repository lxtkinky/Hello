//
//  LXTCalendarController.m
//  HelloWorld
//
//  Created by test on 2018/1/17.
//  Copyright © 2018年 test. All rights reserved.
//

#import "LXTCalendarController.h"
#import "LXTWeekMenuView.h"

#define CELL_WH (kMainScreenWidth - 0.5 * 6) / 7

@interface LXTCalendarController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LXTWeekMenuView *weekMenu;


@property (nonatomic) NSInteger weekday;
@property (nonatomic) NSInteger daycount;
@property (nonatomic) NSInteger preDaycount;

@property (nonatomic) NSDate *currentDate;

@end

@implementation LXTCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.weekMenu];
    [self.weekMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(100);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(CELL_WH);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.weekMenu.mas_bottom);
        make.height.mas_equalTo(CELL_WH * 6 + 0.5 * 7);
    }];
    
    UIButton *preMonthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [preMonthBtn setTitle:@"上一个月" forState:UIControlStateNormal];
    preMonthBtn.backgroundColor = RGBCOLOR(arc4random() % 154 + 100, arc4random() % 154 + 100, arc4random() % 154 + 100);
    preMonthBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self prevMonthClick];
        return [RACSignal empty];
    }];
    [self.view addSubview:preMonthBtn];
    [preMonthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(30);
        make.top.equalTo(self.collectionView.mas_bottom).with.offset(30);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *nextMonthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextMonthBtn setTitle:@"下一个月" forState:UIControlStateNormal];
    nextMonthBtn.backgroundColor = RGBCOLOR(arc4random() % 154 + 100, arc4random() % 154 + 100, arc4random() % 154 + 100);
    nextMonthBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self nextMonthClick];
        return [RACSignal empty];
    }];
    [self.view addSubview:nextMonthBtn];
    [nextMonthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-30);
        make.top.equalTo(self.collectionView.mas_bottom).with.offset(30);
        make.height.mas_equalTo(40);
        make.left.equalTo(preMonthBtn.mas_right).with.offset(30);
        make.width.equalTo(preMonthBtn);
    }];
    
    _currentDate = [NSDate date];
    
    [self loadDateData];
    
}

- (void)loadDateData{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger calendarFlag = NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSDate *preEndDate = nil;
    NSTimeInterval inteval = 0;
//    [calendar setFirstWeekday:2];
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&inteval forDate:_currentDate];
    endDate = [beginDate dateByAddingTimeInterval:inteval - 1];
    preEndDate = [beginDate dateByAddingTimeInterval:-1];
    NSDateComponents *comps = [calendar components:calendarFlag fromDate:beginDate];
    self.weekday = [comps weekday]; // == 6 ? 0 : [comps weekday] + 1;
    NSLog(@"weekday - %ld", self.weekday);
    NSDateComponents *comps2 = [calendar components:calendarFlag fromDate:endDate];
    self.daycount = [comps2 day];
    NSDateComponents *comps3 = [calendar components:calendarFlag fromDate:preEndDate];
    self.preDaycount = [comps3 day];
}

- (void)prevMonthClick{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];
    [comps setMonth:-1];
    [comps setDay:0];
    _currentDate = [calendar dateByAddingComponents:comps toDate:_currentDate options:0];
    [self loadDateData];
    [self.collectionView reloadData];
    
//    NSDate *beginDate = nil;
//    NSDate *endDate = nil;
//    NSDate *preEndDate = nil;
//    NSTimeInterval inteval = 0;
//    [calendar setFirstWeekday:2];
//    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&inteval forDate:[NSDate date]];
//    beginDate = [beginDate dateByAddingTimeInterval:-1];
//    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&inteval forDate:beginDate];
//    endDate = [beginDate dateByAddingTimeInterval:inteval - 1];
//    preEndDate = [beginDate dateByAddingTimeInterval:-1];
//    NSDateComponents *comps = [calendar components:calendarFlag fromDate:beginDate];
//    self.weekday = [comps weekday] + 1;
//    NSDateComponents *comps2 = [calendar components:calendarFlag fromDate:endDate];
//    self.daycount = [comps2 day];
//    NSDateComponents *comps3 = [calendar components:calendarFlag fromDate:preEndDate];
//    self.preDaycount = [comps3 day];
    
}

- (void)nextMonthClick{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];
    [comps setMonth:1];
    [comps setDay:0];
    _currentDate = [calendar dateByAddingComponents:comps toDate:_currentDate options:0];
    [self loadDateData];
    [self.collectionView reloadData];
    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSInteger calendarFlag = NSCalendarUnitDay | NSCalendarUnitWeekday;
//    NSDate *beginDate = nil;
//    NSDate *endDate = nil;
//    NSDate *preEndDate = nil;
//    NSTimeInterval inteval = 0;
//    [calendar setFirstWeekday:2];
//    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&inteval forDate:[NSDate date]];
//    beginDate = [beginDate dateByAddingTimeInterval:inteval + 1];
//    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&inteval forDate:beginDate];
//    endDate = [beginDate dateByAddingTimeInterval:inteval + 1];
//    preEndDate = [beginDate dateByAddingTimeInterval:-1];
//    NSDateComponents *comps = [calendar components:calendarFlag fromDate:beginDate];
//    self.weekday = [comps weekday] + 1;
//    NSDateComponents *comps2 = [calendar components:calendarFlag fromDate:endDate];
//    self.daycount = [comps2 day];
//    NSDateComponents *comps3 = [calendar components:calendarFlag fromDate:preEndDate];
//    self.preDaycount = [comps3 day];
//    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 42;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    cell.backgroundColor = RGBCOLOR(arc4random() % 155 + 100, arc4random() % 155 + 100, arc4random() % 155 + 100);
    UILabel *label;
    if (cell.contentView.subviews.count == 0) {
        label = [[UILabel alloc] init];
        label.tag = 1001;
        label.font = [UIFont fontWithName:PingFang_SC_Medium size:12];
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell.contentView);
        }];
    }
    else{
        label = [cell.contentView viewWithTag:1001];
    }
    
    if (indexPath.row < _weekday - 1) {
        label.text = [NSString stringWithFormat:@"%ld", self.preDaycount - (_weekday - 2) + indexPath.row];
        label.textColor = [UIColor grayColor];
    }
    else if (indexPath.row < _daycount + _weekday - 1) {
        label.text = [NSString stringWithFormat:@"%ld", indexPath.row -(_weekday - 2)];
        label.textColor = [UIColor blackColor];
    }
    else{
        label.text = [NSString stringWithFormat:@"%ld", indexPath.row - _daycount - _weekday + 2];
        label.textColor = [UIColor grayColor];
    }
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CELL_WH, CELL_WH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.5, 0, 0.5, 0 );
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.5;
}

#pragma mark - getter setter
static NSString *collectionCell = @"collectionCell";
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (LXTWeekMenuView *)weekMenu{
    if (!_weekMenu) {
        _weekMenu = [[LXTWeekMenuView alloc] init];
    }
    
    return _weekMenu;
}

@end
