//
//  MVVMTableCell.h
//  HelloWorld
//
//  Created by lixt on 2018/4/13.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickBlock)();

@interface MVVMTableCell : UITableViewCell

@property (nonatomic, strong) ButtonClickBlock buttonClickBlock;
@property (nonatomic, strong) RACSubject *btnClickSubject;

@end
