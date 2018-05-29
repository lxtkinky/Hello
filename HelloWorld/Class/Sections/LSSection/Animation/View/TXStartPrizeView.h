//
//  TXStartPrizeView.h
//  HelloWorld
//
//  Created by ken on 2018/5/28.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXStartPrizeView : UIView

@property (nonatomic, strong) RACSubject *startSubject;

+ (instancetype)startPrizeView;

@end
