//
//  BTCViewController.m
//  HelloWorld
//
//  Created by ken on 2018/5/5.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "BTCViewController.h"
#import "TXNetworkManager.h"
#import "TXBTCModel.h"

@interface BTCViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *apiDict;
@property (nonatomic, strong) NSMutableDictionary *DataDict;

@end

@implementation BTCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _apiDict = @{@"BTC" : @"https://api.btctrade.com/api/ticker?coin=btc",
                           @"ETH" : @"https://api.btctrade.com/api/ticker?coin=eth",
                           @"ETC" : @"https://api.btctrade.com/api/ticker?coin=etc",
                           @"LTC" : @"https://api.btctrade.com/api/ticker?coin=ltc",
                           @"DOGE" : @"https://api.btctrade.com/api/ticker?coin=doge",
                           @"YBC" : @"https://api.btctrade.com/api/ticker?coin=ybc"
                           };
    NSDictionary *depthDict = @{@"BTC" : @"https://api.btctrade.com/api/depth?coin=btc",
                           @"ETH" : @"https://api.btctrade.com/api/depth?coin=eth",
                           @"ETC" : @"https://api.btctrade.com/api/depth?coin=etc",
                           @"LTC" : @"https://api.btctrade.com/api/depth?coin=ltc",
                           @"DOGE" : @"https://api.btctrade.com/api/depth?coin=doge",
                           @"YBC" : @"https://api.btctrade.com/api/depth?coin=ybc"
                           };
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(64, 0, 0, 0 ));
    }];
    
    [self loadData];

}

- (void)loadData{
    
    dispatch_queue_t queue1 = dispatch_queue_create("network.queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_async(group, queue1, ^{
        NSString *urlStr = _apiDict[@"BTC"];
        [[TXNetworkManager sharedInstance] getRequest:urlStr success:^(id responseObj) {
            NSLog(@"BTC result = %@", responseObj);
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"error = %@", error);
        }];
    });
    
    
//    dispatch_queue_t queue2 = dispatch_queue_create("network.queue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_enter(group);
    dispatch_group_async(group, queue1, ^{
        NSString *urlStr = _apiDict[@"ETH"];
        [[TXNetworkManager sharedInstance] getRequest:urlStr success:^(id responseObj) {
            NSLog(@"ETH result = %@", responseObj);
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"error = %@", error);
        }];
    });
    
//    dispatch_queue_t queue3 = dispatch_queue_create("network.queue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_enter(group);
    dispatch_group_async(group, queue1, ^{
        NSString *urlStr = _apiDict[@"LTC"];
        [[TXNetworkManager sharedInstance] getRequest:urlStr success:^(id responseObj) {
            NSLog(@"LTC result = %@", responseObj);
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"error = %@", error);
        }];
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue1, ^{
        NSString *urlStr = _apiDict[@"ETC"];
        [[TXNetworkManager sharedInstance] getRequest:urlStr success:^(id responseObj) {
            NSLog(@"LTC result = %@", responseObj);
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"error = %@", error);
        }];
    });
    
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue1, ^{
        NSString *urlStr = _apiDict[@"DOGE"];
        [[TXNetworkManager sharedInstance] getRequest:urlStr success:^(id responseObj) {
            NSLog(@"DOGE result = %@", responseObj);
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"error = %@", error);
        }];
    });
    
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue1, ^{
        NSString *urlStr = _apiDict[@"YBC"];
        [[TXNetworkManager sharedInstance] getRequest:urlStr success:^(id responseObj) {
            NSLog(@"YBC result = %@", responseObj);
            TXBTCModel *model = [TXBTCModel modelFromDict:responseObj];
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"error = %@", error);
        }];
    });
    
    dispatch_group_notify(group, queue1, ^{
        NSLog(@"都完了");
    });
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _apiDict.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [_apiDict.allKeys objectAtIndex:indexPath.row];
    return cell;
}

- (NSMutableDictionary *)DataDict{
    if (!_DataDict) {
        _DataDict = [[NSMutableDictionary alloc] init];
    }
    return _DataDict;
}

@end
