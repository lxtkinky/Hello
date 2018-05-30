//
//  TXDiscView.h
//  HelloWorld
//
//  Created by ken on 2018/5/26.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXDiscView : UIView

@property (nonatomic, strong) RACSubject *endSubject;

@property (nonatomic, strong) NSMutableArray *iconArray;
@property (nonatomic, strong) NSArray *titleArray;

+ (instancetype)discViewWithFrame:(CGRect)frame;

@end
