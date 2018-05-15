//
//  TXWebSocketManager.m
//  HelloWorld
//
//  Created by ken on 2018/5/9.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXWebSocketManager.h"
#import <SocketRocket/SocketRocket.h>
#import "TXEncryptTool.h"

@interface TXWebSocketManager()<SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *socket;

@end

@implementation TXWebSocketManager


+ (instancetype)socketManager{
    return [[TXWebSocketManager alloc] init];
}

- (void)openSocketWithURLString:(NSString *)urlStr{
    urlStr = [urlStr stringByAppendingString:[TXEncryptTool socketEncryptKey]];
    if (!self.socket) {
        self.socket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlStr]];
        self.socket.delegate = self;
        [self.socket open];
    }
    
//    self.socket
   
}

- (void)sendMessage:(NSString *)message{
    [self.socket send:message];
}

- (void)closeSocket{
    [self.socket close];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    self.socketRecBlock(message);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string{
    self.socketRecBlock(string);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data{
    self.socketRecBlock(data);
}

#pragma mark Status & Connection
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
//    [self.socket ]
    self.socketOpenBlock();
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    self.socketFailBlock(error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean{
    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePingWithData:(nullable NSData *)data{
    
}

@end
