//
//  BTCViewController.m
//  HelloWorld
//
//  Created by ken on 2018/5/5.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "BTCViewController.h"

@interface BTCViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *apiDict;

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

@end
