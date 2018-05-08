//
//  TXTableViewHelper.m
//  HelloWorld
//
//  Created by ken on 2018/5/5.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXTableViewHelper.h"

@implementation TXTableViewHelper

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

@end
