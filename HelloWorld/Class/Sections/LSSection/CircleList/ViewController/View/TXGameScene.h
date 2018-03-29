//
//  TXGameScene.h
//  HelloSpritekit
//
//  Created by lixt on 2018/3/13.
//  Copyright © 2018年 lixt. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef void(^GameOverBlock)();

@interface TXGameScene : SKScene

@property (nonatomic, copy) GameOverBlock gameOverBlock;

- (void)gameStart;

@end
