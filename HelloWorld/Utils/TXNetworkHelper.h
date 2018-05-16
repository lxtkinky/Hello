//
//  TXNetworkHelper.h
//  HelloWorld
//
//  Created by ken on 2018/5/16.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TXNetworkStatus) {
    TXNetworkStatusWAN = 0,
    TXNetworkStatusWIFI,
    TXNetworkStatusNotReachable,
    TXNetworkStatusUnknown
};

@interface TXNetworkHelper : NSObject

@property (nonatomic) TXNetworkStatus status;

TX_SINGLETON_DEF(TXNetworkHelper)

- (void)startNetworkReach;

@end
