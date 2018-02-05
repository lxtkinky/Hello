//
//  VFNetAPIClient.m
//  VShareFree
//
//  Created by ZhaoHanjun on 16/6/20.
//  Copyright © 2016年 https://github.com/CoderHJZhao. All rights reserved.
//

#import "VFNetAPIClient.h"
//#import "UserManager.h"

@interface VFNetAPIClient() {
    
}

@end

@implementation VFNetAPIClient

+ (id)netWorkClient
{
    static VFNetAPIClient *shareInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] initWithBaseURL:nil];
    });
    
    return shareInstance;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    self.requestSerializer.timeoutInterval = 20;

    
    return self;
    
}

- (NSURLSessionDataTask *)requestJsonDataWithPath:(NSString *)path
                                       withParams:(NSDictionary*)params
                                   withMethodType:(VFNetworkMethod)method
                                     successBlock:(JsonDataCallBack)successBlock failureBlock:(JsonDataCallBack)failureBlock
{
    //self.responseSerializer = [AFJSONResponseSerializer serializer];
//    NSString *ss = [UserManager shareInstance].session;
//    if (ss.length > 0) {
//        [self.requestSerializer setValue:[UserManager shareInstance].session forHTTPHeaderField:@"Authorization"];
//    }
//
//    if ([@"api/login" isEqualToString:path]) {
//        [self.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
//    }
    
//    NSLog(@"%@", [UserManager shareInstance].session);
 
    NSURLSessionDataTask *requestTask = nil;
    switch (method) {
        case Get:{
            requestTask = [self GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
        }
            break;
        case Post:{
            requestTask = [self POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if([path containsString:@"api/login"]) {//只有登录接口才有session， 为什么不放在登录接口
                    NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                    NSDictionary *dic = r.allHeaderFields;
                    
//                    [UserManager shareInstance].session = [dic objectForKey:@"Set-Cookie"];
                }
                
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
        }
            break;
        case Put:{
            requestTask = [self PUT:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
                
            }];
            
        }
            break;
        case Delete:{
            requestTask = [self DELETE:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
                
            }];
            
        }
            break;
        default:
            break;
    }
    return requestTask;
}
@end


