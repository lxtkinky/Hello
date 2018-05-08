//
//  TXShareManager.h
//  TestDemo003
//
//  Created by ken on 2018/5/8.
//  Copyright © 2018年 lixt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TXWXScene) {
    TXWXSceneSession = 0,  //聊天界面
    TXWXSceneTimeline,     //朋友圈
    TXWXSceneFavorite       //收藏
};

@interface TXShareManager : NSObject

+ (instancetype)sharedManager;

+ (instancetype)alloc __attribute__((unavailable("call sharedInstance instead")));
+ (instancetype)new __attribute__((unavailable("call sharedInstance instead")));
- (id)copy __attribute__((unavailable("call sharedInstance instead")));
- (id)mutableCopy __attribute__((unavailable("call sharedInstance instead")));

/*
 * !分享到微信
 * @param message 分享内容
 * @param scene 分享场景  朋友圈、聊天界面、收藏
 */
- (void)shareMessageToWchat:(NSString *)message scene:(TXWXScene)scene;

@end

/*
 集成微信：
 1、导入SDK
 2、添加想要的framework和动态库
     1.SystemConfiguration.framework
     2.CoreTelephony.framework
     3.Security.framework
     4.CFNetwork.framework
     5.libsqlite3.0.tbd
     6.libz.1.2.8.tbd
     7.libc++.tbd
 3、设置Other Linker Flags为"-Objc -all_load"
 4、设置URL scheme ID为微信生成的ID如：wxd930ea5d5a258f4f
 4、在应用里注册你的appID
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
         [WXApi registerApp:@"wxd930ea5d5a258f4f"];//注册appID
         return YES;
     }
5、调用微信API
 */
