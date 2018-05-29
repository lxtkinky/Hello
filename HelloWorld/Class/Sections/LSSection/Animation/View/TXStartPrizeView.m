//
//  TXStartPrizeView.m
//  HelloWorld
//
//  Created by ken on 2018/5/28.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXStartPrizeView.h"

@interface TXStartPrizeView()
@property (weak, nonatomic) IBOutlet UIImageView *backImageV;
@property (weak, nonatomic) IBOutlet UILabel *startButton;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation TXStartPrizeView

+ (instancetype)startPrizeView{
    TXStartPrizeView *startPrizeView = [[[NSBundle mainBundle] loadNibNamed:@"TXStartPrizeView" owner:self options:nil] firstObject];
    [startPrizeView tx_initSubView];
    return startPrizeView;
}

- (void)tx_initSubView{
    self.descLabel.layer.cornerRadius = 12.0;
    self.descLabel.clipsToBounds = YES;
}

//开始抽奖
- (IBAction)startButtonClick:(id)sender {
    [self.startSubject sendNext:nil];
}

- (RACSubject *)startSubject{
    if (!_startSubject) {
        _startSubject = [[RACSubject alloc] init];
    }
    return _startSubject;
}


@end
