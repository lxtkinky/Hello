//
//  TXWebSocketManager.h
//  HelloWorld
//
//  Created by ken on 2018/5/9.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SocketOpenSuccess)();

typedef void(^SocketFail)(NSError *);

typedef void(^SocketReceiveMessage)(id);

@interface TXWebSocketManager : NSObject


+ (instancetype)socketManager;

@property (nonatomic, strong) SocketOpenSuccess socketOpenBlock;

@property (nonatomic, strong) SocketFail socketFailBlock;

@property (nonatomic, strong) SocketReceiveMessage socketRecBlock;

- (void)openSocketWithURLString:(NSString *)urlStr;

- (void)sendMessage:(NSString *)message;

- (void)closeSocket;


@end
