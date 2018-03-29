//
//  SpriteKitController.m
//  HelloWorld
//
//  Created by lixt on 2018/3/14.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "SpriteKitController.h"
#import "TXGameScene.h"

@interface SpriteKitController ()
@property (nonatomic,strong) TXGameScene *gameScene;
@property (nonatomic, strong) UIView *menuView;

@end

@implementation SpriteKitController

- (void)viewDidLoad {
    [super viewDidLoad];
    SKView *skView = [[SKView alloc] initWithFrame:self.view.bounds];
    
    
    [self.view addSubview:skView];
    TXGameScene *scene = [[TXGameScene alloc] initWithSize:self.view.bounds.size];
    self.gameScene = scene;
    [skView presentScene:scene];
    skView.showsFPS = YES;
    skView.ignoresSiblingOrder = YES;
    skView.showsNodeCount = YES;
    
    UIView *menuView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.menuView = menuView;
    menuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:menuView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"开始游戏" forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, 200, 60);
    button.center = menuView.center;
    button.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    [menuView addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    __block __weak SpriteKitController *weakSelf = self;
    self.gameScene.gameOverBlock = ^{
        weakSelf.menuView.hidden = NO;
    };
}

- (void)buttonClick{
    self.menuView.hidden = YES;
    [self.gameScene gameStart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
