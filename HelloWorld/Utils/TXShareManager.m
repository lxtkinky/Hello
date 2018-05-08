//
//  TXShareManager.m
//  TestDemo003
//
//  Created by ken on 2018/5/8.
//  Copyright © 2018年 lixt. All rights reserved.
//

#import "TXShareManager.h"
#import "WXApi.h"

static TXShareManager *manager;

@implementation TXShareManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super alloc] init];
    });
    return manager;
}

- (void)shareMessageToWchat:(NSString *)message scene:(TXWXScene)scene{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = message;
    switch (scene) {
        case TXWXSceneSession:
            req.scene = WXSceneSession;
            break;
        case TXWXSceneFavorite:
            req.scene = WXSceneFavorite;
            break;
            
        default:
            req.scene = WXSceneTimeline;
            break;
    }
    
    [WXApi sendReq:req];
}



@end
