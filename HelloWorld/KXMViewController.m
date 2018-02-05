//
//  KXMViewController.m
//  HelloWorld
//
//  Created by test on 17/12/20.
//  Copyright © 2017年 test. All rights reserved.
//

#import "KXMViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Masonry.h"
#import <MediaPlayer/MediaPlayer.h>
#import "LTAVPlayerView.h"

static NSString *cloudURL = @"http://hls.kan1.live.anyan.com/live_60875_103875/m3u8?sign=1513839731-48cc1f190412b437c8adf20abd836054&device_sn=Ay0000000000002107UM&video_rate=700&channel_id=1&customer=60875_103875";

@interface KXMViewController ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIButton *stopPlayerBtn;
@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) LTAVPlayerView *playerView;

@end

@implementation KXMViewController
{
    id _playTimeObserver; // 观察者
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testLTAVPlayer];
}

- (void)testLTAVPlayer{
    LTAVPlayerView *playerView = [[LTAVPlayerView alloc] init];
    self.playerView = playerView;
    [playerView setVedioURL:cloudURL];
    [self.view addSubview:playerView];
    [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.playerView updatePlayerLayerFrame];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
}

//- (void)lxt_AddComstraints{
//    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.view);
//        make.left.equalTo(self.view).with.offset(20);
//        make.size.mas_equalTo(CGSizeMake(150, 40));
//    }];
//
//    [self.stopPlayerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.view);
//        make.left.equalTo(self.playBtn.mas_right).with.offset(20);
//        make.size.equalTo(self.playBtn);
//    }];
//}



- (UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.backgroundColor = [UIColor greenColor];
        _button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return [RACSignal empty];
        }];
        
    }
    return _button;
}




- (UIButton *)stopPlayerBtn{
    if (!_stopPlayerBtn) {
        _stopPlayerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _stopPlayerBtn.backgroundColor = [UIColor greenColor];
        [_stopPlayerBtn setTitle:@"stop" forState:UIControlStateNormal];
    }
    return _stopPlayerBtn;
}

- (UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.backgroundColor = [UIColor greenColor];
        [_playBtn setTitle:@"play" forState:UIControlStateNormal];
        _playBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal empty];
        }];
    }
    
    return _playBtn;
}

@end
