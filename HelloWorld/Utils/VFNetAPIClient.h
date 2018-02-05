//
//  VFNetAPIClient.h
//  VShareFree
//
//  Created by ZhaoHanjun on 16/6/20.
//  Copyright © 2016年 https://github.com/CoderHJZhao. All rights reserved.
//

#import "AFNetworking.h"

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} VFNetworkMethod;

typedef void(^JsonDataCallBack)(id value);

@interface VFNetAPIClient : AFHTTPSessionManager

+ (id)netWorkClient;

- (NSURLSessionDataTask *)requestJsonDataWithPath:(NSString *)path
                                       withParams:(NSDictionary*)params
                                   withMethodType:(VFNetworkMethod)method
                                     successBlock:(JsonDataCallBack)successBlock failureBlock:(JsonDataCallBack)failureBlock;

@end
