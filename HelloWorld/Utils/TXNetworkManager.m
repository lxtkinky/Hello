//
//  TXNetworkManager.m
//  HelloWorld
//
//  Created by ken on 2018/5/9.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXNetworkManager.h"
#import <AFNetworking/AFNetworking.h>

@interface TXNetworkManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation TXNetworkManager

+ (TXNetworkManager *)sharedInstance{
    
    static TXNetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super alloc] init];
        instance.manager = [AFHTTPSessionManager manager];
        instance.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        instance.manager.requestSerializer.timeoutInterval = 20;
    });
    
    return instance;
}

- (void)getRequest:(NSString *)urlString success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock{
    [self.manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

@end
