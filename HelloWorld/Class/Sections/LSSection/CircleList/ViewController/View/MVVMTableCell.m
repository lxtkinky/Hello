//
//  MVVMTableCell.m
//  HelloWorld
//
//  Created by lixt on 2018/4/13.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "MVVMTableCell.h"

@implementation MVVMTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonClick:(id)sender {
//    if (self.buttonClickBlock) {
//        self.buttonClickBlock();
//    }
//    
//    if (self.btnClickSubject) {
//        [self.btnClickSubject sendNext:self];
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (RACSubject *)btnClickSubject{
    if (!_btnClickSubject) {
        _btnClickSubject = [RACSubject subject];
    }
    return _btnClickSubject;
}

@end
