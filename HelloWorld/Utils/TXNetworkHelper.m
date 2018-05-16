//
//  TXNetworkHelper.m
//  HelloWorld
//
//  Created by ken on 2018/5/16.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXNetworkHelper.h"

@implementation TXNetworkHelper

TX_SINGLETON_IMP(TXNetworkHelper)

- (void)startNetworkReach{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.status = TXNetworkStatusWAN;
                NSLog(@"TXNetworkStatusWLAN");
                break;
            
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.status = TXNetworkStatusWIFI;
                NSLog(@"TXNetworkStatusWIFI");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                self.status = TXNetworkStatusNotReachable;
                NSLog(@"TXNetworkStatusNotReachable");
                break;
                
            default:
                self.status = TXNetworkStatusUnknown;
                NSLog(@"TXNetworkStatusUnknown");
                break;
        }
    }];
    
    [manager startMonitoring];
}

@end
