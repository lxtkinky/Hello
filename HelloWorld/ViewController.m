//
//  ViewController.m
//  HelloWorld
//
//  Created by test on 17/12/18.
//  Copyright © 2017年 test. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "SecondViewController.h"
#import "SDWebImageController.h"
#import "AFNViewController.h"
#import "KXMViewController.h"
#import "MapViewController.h"
#import "MJRefresh.h"
#import "UIAlertController+Custom.h"
#import "UIAlertAction+Custom.h"
#import "ProgressViewController.h"
//#import "CustomButtonController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ViewModel *viewModel;
@property (nonatomic, strong) UIAlertController *action;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation ViewController{
    NSArray *_titleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor grayColor];
    
    _titleArray = @[@"AFN", @"AVPlayer", @"Action",@"Image", @"map",
                    @"ProgressViewController", @"KVOViewController",
                    @"WebViewController", @"AlipayViewController",
                    @"NotificationViewController", @"ArchieveViewController",
                    @"CustomButtonController", @"GCDViewController",
                    @"FMDBController", @"CalendarController",
                    @"LXTCalendarController"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];

    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self.viewModel requestDataWithPull:YES];
//    });
    
//    [self.view addSubview:self.activityView];
//    [self.activityView startAnimating];
//    self.activityView.hidden = YES;
//    self.activityView.center = self.view.center;
//    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];
    
        [self.viewModel requestDataWithPull:YES];
    
//    [self alert];
    
    
}

- (void)alert{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"关注老人"
                                                                       message:@"请先完善您的个人信息"
                                                                preferredStyle:UIAlertControllerStyleAlert];
//    NSMutableAttributedString *alertAttrStr = [[NSMutableAttributedString alloc] initWithString:@"关注老人"];
//    [alertAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, alertAttrStr.length)];
//    [alertAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, alertAttrStr.length)];
//    [alertView setValue:alertAttrStr forKey:@"attributedTitle"];
    
//    NSMutableAttributedString *alertMsgAttrStr = [[NSMutableAttributedString alloc] initWithString:@"请先完善您的个人信息"];
//    [alertMsgAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, alertAttrStr.length)];
//    [alertMsgAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, alertAttrStr.length)];
//    [alertView setValue:alertMsgAttrStr forKey:@"attributedMessage"];
    [alertView setTitleFont:[UIFont systemFontOfSize:20] color:[UIColor blueColor]];
    [alertView setmessageFont:[UIFont systemFontOfSize:15.0] color:[UIColor grayColor]];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
//    [cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [cancelAction setTitleColor:[UIColor redColor]];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"立即完善"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           NSLog(@"");
                                                       }];
    [alertView addAction:cancelAction];
    [alertView addAction:sureAction];
    [self presentViewController:alertView animated:YES completion:nil];
}


- (void)updateViewConstraints{
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    
    [super updateViewConstraints];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.viewModel.dataArray.count;
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row < _titleArray.count) {
        cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = [NSString stringWithFormat:@"the %ld line", indexPath.row + 1];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        AFNViewController *afnVC = [[AFNViewController alloc] init];
        [self.navigationController pushViewController:afnVC animated:YES];
        return;
    }
    
    if (indexPath.row == 1) {
        KXMViewController *kxmVC = [[KXMViewController alloc] init];
        [self.navigationController pushViewController:kxmVC animated:YES];
        return;
    }
    
    if (indexPath.row == 2) {
        [self presentViewController:self.action animated:YES completion:nil];
        return;
    }
    
    if (indexPath.row == 3) {
        SDWebImageController *webImageVC = [[SDWebImageController alloc] init];
        [self.navigationController pushViewController:webImageVC animated:YES];
        return;
    }
    
    if (indexPath.row == 4) {
        MapViewController *mapVC = [[MapViewController alloc] init];
        [self.navigationController pushViewController:mapVC animated:YES];
        return;
    }


//    if (indexPath.row == 11) {
//        UIViewController *controller = [[UIViewController alloc] initWithNibName:[_titleArray objectAtIndex:indexPath.row] bundle:nil];
//        [self.navigationController pushViewController:controller animated:YES];
//    }
    
    if (indexPath.row < _titleArray.count) {
        UIViewController *viewController = [[NSClassFromString([_titleArray objectAtIndex:indexPath.row]) alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
//    SecondViewController *secondVC = [[SecondViewController alloc] init];
//    secondVC.delegateSubject = [RACSubject subject];
//    @weakify(self)
//    [secondVC.delegateSubject subscribeNext:^(id x) {
//        @strongify(self)
//        [self.viewModel requestDataWithPull:NO];
//        NSLog(@"receive singal!-->%@", x);
//    }];
    
//    [self.navigationController pushViewController:secondVC animated:YES];
    
}


#pragma mark - getter setter

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [_tableView.mj_header endRefreshing];
            
            _activityView.hidden = NO;
            [_activityView startAnimating];
        }];
    }
    return _tableView;
}

- (UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        _activityView.hidden = YES;
    }
    return _activityView;
}

- (ViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[ViewModel alloc] init];
        [_viewModel.tableSubject subscribeNext:^(id x) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }];
    }
    
    return _viewModel;
}


- (UIAlertController *)action{
    if (_action == nil) {
        _action = [UIAlertController alertControllerWithTitle:@"action" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [_action addAction:[UIAlertAction actionWithTitle:@"yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"yes");
        }]];
    }
    return _action;
}


@end
