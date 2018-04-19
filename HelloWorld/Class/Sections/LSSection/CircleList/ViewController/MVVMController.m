//
//  MVVMController.m
//  HelloWorld
//
//  Created by lixt on 2018/4/13.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "MVVMController.h"
#import "MVVMViewModel.h"
#import "MVVMTableCell.h"
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>
#import <ReactiveObjC/NSNotificationCenter+RACSupport.h>

@interface MVVMController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MVVMViewModel *vm;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MVVMController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MVVMTableCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    self.dataArr = @[@"111", @"2222", @"333", @"444", @"555", @"666"];
    
    self.vm = [[MVVMViewModel alloc] init];
    [self.vm loadData];
    __block __weak typeof(self) weakSelf = self;
    [self.vm setLoadDataSuccess:^{
        [weakSelf.tableView reloadData];
    }];
    
    
    [self.view rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        NSLog(@"value=%@", value);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(-40);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonClickNotification" object:nil];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"buttonClickNotification" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"notification = %@", x);
    }];
    
    //RAC timer
    [[RACSignal interval:1.0 onScheduler:[RACScheduler scheduler] withLeeway:2.0] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"RAC timer %@", x);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MVVMTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *str = [self.dataArr objectAtIndex:indexPath.row];
    cell.textLabel.text = str;
//    [cell.btnClickSubject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"点击%@", x);
//    }];
    
    [[cell rac_signalForSelector:@selector(buttonClick:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
//    cell.buttonClickBlock = ^{
//        //VC跳转  请求服务器
//        
//    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
