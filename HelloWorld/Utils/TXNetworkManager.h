//
//  TXNetworkManager.h
//  HelloWorld
//
//  Created by ken on 2018/5/9.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BaseModel.h"

typedef void(^SuccessBlock)(id);
typedef void(^FailureBlock)(NSError *);

@interface TXNetworkManager : NSObject

TX_SINGLETON_DEF(TXNetworkManager)

- (void)getRequest:(NSString *)urlString success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end
