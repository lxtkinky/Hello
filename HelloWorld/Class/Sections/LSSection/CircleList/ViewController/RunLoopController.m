//
//  RunLoopController.m
//  HelloWorld
//
//  Created by lixt on 2018/4/3.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "RunLoopController.h"

@interface RunLoopController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RunLoopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"meinv" ofType:@"jpg"];
        imageView.image = [[UIImage alloc] initWithContentsOfFile:imagePath];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor redColor];
        [array addObject:imageView];
        [cell.contentView addSubview:imageView];
    }
    
    for (int i = 0; i < array.count; i++) {
        UIImageView *imageView = [array objectAtIndex:i];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(cell.contentView).with.offset(5);
            }
            else{
                UIImageView *preView = [array objectAtIndex: i - 1];
                make.left.equalTo(preView.mas_right).with.offset(5);
                make.width.equalTo(preView);
            }
            
            make.top.equalTo(cell.contentView).with.offset(5);
            make.bottom.equalTo(cell.contentView).with.offset(-5);
            
            if (i == array.count -1) {
                make.right.equalTo(cell.contentView).with.offset(-5);
            }
        }];
    }
    
    return cell;
}

@end
