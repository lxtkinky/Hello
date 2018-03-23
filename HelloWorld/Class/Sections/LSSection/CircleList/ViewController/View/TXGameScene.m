//
//  TXGameScene.m
//  HelloSpritekit
//
//  Created by lixt on 2018/3/13.
//  Copyright © 2018年 lixt. All rights reserved.
//

#import "TXGameScene.h"

typedef NS_ENUM(NSInteger, GameStatus) {
    GameStatusIdle,     //初始化
    GameStatusRuning,   //进行中
    GameStatusOver      //结束
};

static const uint32_t runnerCategory       =  0x1 << 0;
static const uint32_t floorCategory       =  0x1 << 1;
static const uint32_t boardCategory       =  0x1 << 2;
//static const uint32_t StageCategory        =  0x1 << 3;

NSString *runerAnimatekey = @"run";

@interface TXGameScene()<SKPhysicsContactDelegate>

//@property (nonatomic, strong) SKSpriteNode *player;
@property (nonatomic, strong) NSMutableArray *playerRunFrames;
@property (nonatomic, strong) SKSpriteNode *runner;
@property (nonatomic, strong) NSMutableArray *boardArray;
@property (nonatomic, strong) NSTimer *boardTimer;
@property (nonatomic) BOOL isJump;
@property (nonatomic) BOOL isTop;
@property (nonatomic, strong) SKSpriteNode *currentBoard;
@property (nonatomic) CGFloat moveSpeed;
@property (nonatomic) BOOL firstStart;
@property (nonatomic) NSDate *lastJumpTime;
//@property (nonatomic) BOOL moveStatus;  //地面和跳板移动标示

@end

@implementation TXGameScene{
    SKSpriteNode *_floor1;
    SKSpriteNode *_floor2;
//    SKSpriteNode *_runner;
    GameStatus gameStatus;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.physicsWorld.contactDelegate = self;
    }
    return self;
}

- (instancetype)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if (self) {
        self.physicsWorld.contactDelegate = self;
        self.moveSpeed = 3.0;
        self.firstStart = YES;
        self.lastJumpTime = [NSDate new];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view{
    self.backgroundColor = [SKColor colorWithRed:123/255.0 green:132/255.0 blue:110/255.0 alpha:1.0];
    _floor1 = [SKSpriteNode spriteNodeWithImageNamed:@"sceneView_ground"];
    _floor1.anchorPoint = CGPointMake(0, 0 );
    _floor1.position = CGPointMake(0, 0);
    _floor1.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, _floor1.size.width, _floor1.size.height)];
    _floor1.physicsBody.categoryBitMask = floorCategory;
    [self addChild:_floor1];

    _floor2 = [SKSpriteNode spriteNodeWithImageNamed:@"sceneView_ground"];
    _floor2.anchorPoint = CGPointMake(0, 0);
    _floor2.position = CGPointMake(_floor1.size.width, 0);
    _floor2.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, _floor2.size.width, _floor2.size.height)];
    _floor2.physicsBody.categoryBitMask = floorCategory;
    [self addChild:_floor2];
    
    //创建sprite，并将其位置设置为屏幕左侧，然后将其添加到场景中
    self.runner = [[SKSpriteNode alloc] initWithTexture:self.playerRunFrames[0] color:[UIColor clearColor] size:CGSizeMake(30, 40)];
//    self.runner =[SKSpriteNode spriteNodeWithImageNamed:@"perRun1"];
    self.runner.position = CGPointMake(40, self.size.height * 0.5 + 120);
    self.runner.physicsBody = [SKPhysicsBody bodyWithTexture:self.runner.texture size:self.runner.size];    //设置runner的物理体
    self.runner.physicsBody.allowsRotation = NO;        //禁止旋转
    self.runner.physicsBody.categoryBitMask = runnerCategory;   //设置runner的物理体标示
    self.runner.physicsBody.contactTestBitMask = floorCategory | boardCategory; //设置runner碰撞检测的物体
    
    [self addChild:self.runner];
    
    [self shuffle];
    
}

#pragma mark - 初始化游戏
- (void)shuffle{
    
    gameStatus = GameStatusIdle;
    self.runner.position = CGPointMake(40, self.size.height * 0.5 + 120);
    self.runner.physicsBody.dynamic = NO;
//    self.moveStatus = NO;   //地面和跳板不可以移动
    
    for (SKSpriteNode *node in self.boardArray) {
        [node removeFromParent];
    }
    
    self.boardArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        [self addSpringboard];
    }
    self.firstStart = NO;       //是否是第一次开始游戏
}

//开始游戏
- (void)gameStart{
    if (!self.firstStart) {
        [self shuffle];
    }
    gameStatus = GameStatusRuning;
//    self.moveStatus = YES;
    self.runner.physicsBody.dynamic = YES;
    //开始跑动
    [self startRun];
    [self startCreateBoard];
    
//    [self startBoardTimer];
}

//结束游戏
- (void)gameOver{
    gameStatus = GameStatusOver;
//    self.moveStatus = NO;
    [self stopRun];
    
    if (self.gameOverBlock) {
        self.gameOverBlock();
    }
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    switch (gameStatus) {
        case GameStatusIdle:
//            [self gameStart];
            break;
            
            case GameStatusRuning:
            [self runnerJump];
            break;
            
        default:
            [self shuffle];
            break;
    }
}

#pragma mark - 跳跃
#define JumpHeight 90
- (void)runnerJump{
    NSTimeInterval timeInterval = [[NSDate new] timeIntervalSinceDate:self.lastJumpTime];
    if (timeInterval < 0.5) {
        return;
    }
    self.lastJumpTime = [NSDate new];
    SKPhysicsBody *body = self.runner.physicsBody;
//    NSLog(@"%.3f--%.3f==%.3f", body.velocity.dx,body.velocity.dy, body.angularVelocity);
    
    if (body.velocity.dy >= -50 && body.velocity.dy <= 50) {
        [self.runner.physicsBody applyImpulse:CGVectorMake(0, 5)];
    }
    
    return;
    
    if (self.isJump) {
        return;
    }
    
    if (self.currentBoard) {
        if (self.currentBoard.position.y + self.currentBoard.size.height * 0.5 > self.runner.position.y - self.runner.size.height * 0.5 + 10) {
            return;
        }
    }
    //设置为跳跃状态
    self.isJump = YES;
    //删除跑的动画
    [self.runner removeAllActions];
    //跳跃时的动画
    float duration = 0.6;
    
    SKAction *jumpAction = [SKAction animateWithTextures:self.playerRunFrames timePerFrame:0.08 resize:NO restore:YES];
    
    
    //向上移动的动画
    SKAction *moveUpAction = [SKAction moveTo:CGPointMake(self.runner.position.x, self.runner.position.y + JumpHeight) duration:duration/2 + 0.04];
    SKAction *holdAction = [SKAction waitForDuration:0.03];
//    SKAction *moveDownAction=[SKAction moveTo:CGPointMake(self.runner.position.x, self.runner.position.y) duration:duration/2 - 0.04];
    
    __block __weak TXGameScene *weakSelf = self;
    [self.runner runAction:[SKAction group:@[jumpAction,[SKAction sequence:@[moveUpAction,holdAction]]]] completion:^{
        SKAction *runAction=[SKAction repeatActionForever:[SKAction animateWithTextures:weakSelf.playerRunFrames timePerFrame:0.03f resize:NO restore:YES]];
        [weakSelf.runner runAction:runAction withKey:runerAnimatekey];
        weakSelf.isJump = NO;
        weakSelf.isTop = YES;
    }];
}

#pragma mark - 场景内的物体移动
- (void)moveScene{
    if (gameStatus != GameStatusRuning) {
        return;
    }
    //底部栅栏左移
    _floor1.position = CGPointMake(_floor1.position.x - self.moveSpeed, _floor1.position.y);
    _floor2.position = CGPointMake(_floor2.position.x - self.moveSpeed, _floor2.position.y);
    //底部栅栏交替
    if (_floor1.position.x < - _floor1.size.width) {
        _floor1.position = CGPointMake(_floor2.position.x + _floor2.size.width, _floor2.position.y);
    }
    
    if (_floor2.position.x < - _floor2.size.width) {
        _floor2.position = CGPointMake(_floor1.position.x + _floor1.size.width, _floor2.position.y);
    }
    
//    self.currentBoard = nil;
    
    //跳板左移
    for (SKNode *node in [self children]) {
        SKSpriteNode *board = (SKSpriteNode *)node;
        if ([board.name isEqualToString:@"board"]) {
            board.position = CGPointMake(board.position.x - self.moveSpeed, board.position.y);
            if (board.position.x < - board.size.width * 0.5) {
                [self.boardArray removeObject:board];
                [board removeFromParent];
            }
        }
    }
    

    
    /*
    //runner下落
    if (true){
        CGFloat temp = 3;
        if (!self.currentBoard) {
            self.runner.position = CGPointMake(self.runner.position.x, self.runner.position.y - temp);
        }
        else{
            if (self.runner.position.y > self.currentBoard.position.y + self.currentBoard.size.height * 0.5 + self.runner.size.height * 0.5
                || self.runner.position.y < self.currentBoard.position.y + self.currentBoard.size.height * 0.5 + self.runner.size.height * 0.5 - temp - 1) {
                self.runner.position = CGPointMake(self.runner.position.x, self.runner.position.y - temp);
            }
        }
        
        if (self.runner.position.y - self.runner.size.height * 0.5 <= _floor1.position.y + _floor1.size.height * 0.5) {
            [self gameOver];
        }
    }*/
}

//游戏开始，开始跑动
- (void)startRun{
    SKAction *skAction = [SKAction animateWithTextures:self.playerRunFrames timePerFrame:0.03f resize:NO restore:YES];
    [_runner runAction:[SKAction repeatActionForever:skAction] withKey:runerAnimatekey];
    
}

//游戏终止，停止跑动
- (void)stopRun{
    [_runner removeActionForKey:runerAnimatekey];
}

#pragma mark - //添加跳板  springboard 跳板
static NSString *createActionKey = @"createBoard";
- (void)startCreateBoard{
    
    SKAction *waitAction = [SKAction waitForDuration:0 withRange:1.0];
    SKAction *createBoardAction = [SKAction runBlock:^{
        [self createBoard];
    }];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[waitAction, createBoardAction]]] withKey:createActionKey];
}

- (void)createBoard{
    [self addSpringboard];
}

- (void)stopCreateBoard{
    [self removeActionForKey:createActionKey];
}
- (void)addSpringboard{
    
    int width = self.size.width * 1.5;
    CGFloat height = 200;
    CGFloat positionX = width * 0.5;
    CGFloat positionY = self.size.height * 0.5;
    
    if (self.boardArray.count != 0) {
        SKSpriteNode *lastBoard = [self.boardArray lastObject];
        width = arc4random() % 100 + 100;
        height = 5;
        positionX = lastBoard.position.x + lastBoard.size.width * 0.5 + 30 + arc4random() % 40 + width * 0.5;
        positionY = self.size.height * 0.5 - arc4random() % 30;
    }
    SKSpriteNode *board = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor] size:CGSizeMake(width, height)];
    board.position = CGPointMake(positionX, positionY);
    board.name = @"board";
    board.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(board.size.width - 10, board.size.height)];
    board.physicsBody.allowsRotation = NO;
    board.physicsBody.categoryBitMask = boardCategory;
    board.physicsBody.collisionBitMask = runnerCategory;
    board.physicsBody.contactTestBitMask = runnerCategory;
    board.physicsBody.allowsRotation = NO;
    board.physicsBody.affectedByGravity = NO;
//    board.physicsBody.usesPreciseCollisionDetection = YES;
    board.physicsBody.dynamic = NO;
    [self.boardArray addObject:board];
    [self addChild:board];
    
//    self.object.physicsBody.categoryBitMask = objectCategory;
//    self.object.physicsBody.collisionBitMask = playerCategory;
//    self.object.physicsBody.contactTestBitMask = playerCategory;
//    self.object.physicsBody.allowsRotation = NO;
//    self.object.physicsBody.affectedByGravity = NO;
//    self.object.physicsBody.dynamic = NO;
}
#pragma mark -
//启动一个定时器 添加跳板
- (void)startBoardTimer{
    self.boardTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(addSpringboard) userInfo:nil repeats:YES];
}
#pragma mark - 碰撞检测
- (void)didBeginContact:(SKPhysicsContact *)contact{
    if (gameStatus != GameStatusRuning) {
        return;
    }
    
    SKPhysicsBody *bodyA = contact.bodyA;
    SKPhysicsBody *bodyB = contact.bodyB;
    if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) {
        bodyA = contact.bodyB;
        bodyB = contact.bodyA;
    }
    
    if (bodyA.categoryBitMask == runnerCategory && bodyB.categoryBitMask == floorCategory) {
        [self gameOver];
    }
    
    if (bodyA.categoryBitMask == runnerCategory && bodyB.categoryBitMask == boardCategory) {
        
        NSLog(@"%f---%f-->%@-->%@", contact.contactNormal.dx, contact.contactNormal.dy, NSStringFromCGPoint(contact.contactPoint), NSStringFromCGPoint(self.runner.position));
        if (contact.contactNormal.dx > 0) {
//            self.moveStatus = NO;
            [self gameOver];
            SKAction *overAction = [SKAction moveTo:CGPointMake(self.runner.position.x, 100) duration:0.6];
            [self.runner runAction:overAction];
            
        }
    }
}

- (void)update:(NSTimeInterval)currentTime{
    [self moveScene];
//    if (self.runner.position.y  < _floor1.position.y + _floor1.size.height * 0.5 + self.runner.size.height) {
//        [self gameOver];
//    }
//    else{
//        [self moveScene];
//    }
}

- (NSMutableArray *)playerRunFrames{
    if (!_playerRunFrames) {
        //构建一个用于保存跑步帧（run frame）
        _playerRunFrames = [NSMutableArray array];
        //加载纹理图集
        SKTextureAtlas *playerAnimatedAtlas = [SKTextureAtlas atlasNamed:@"perRun"];
        //构建帧列表
        NSInteger numImages = playerAnimatedAtlas.textureNames.count;
        for (int i = 1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"perRun%d", i];
            SKTexture *temp = [playerAnimatedAtlas textureNamed:textureName];
            [_playerRunFrames addObject:temp];
        }
    }
    return _playerRunFrames;
}

- (NSMutableArray *)boardArray{
    if (!_boardArray) {
        _boardArray = [NSMutableArray array];
    }
    return _boardArray;
}

@end
