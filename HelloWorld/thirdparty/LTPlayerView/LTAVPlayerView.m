//
//  LTAVPlayerView.m
//  HelloWorld
//
//  Created by test on 2017/12/25.
//  Copyright © 2017年 test. All rights reserved.
//

#import "LTAVPlayerView.h"
#import <AVKit/AVKit.h>

@interface LTAVPlayerView()

@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, copy) NSString *videoURL;

@end

@implementation LTAVPlayerView

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)addAVPlayer{
    _player = [[AVPlayer alloc] init];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _playerLayer.frame = self.bounds;
    [self.layer addSublayer:_playerLayer];
    
    _playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:_videoURL]];
    [_player replaceCurrentItemWithPlayerItem:_playerItem];
    
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setVedioURL:(NSString *)videoURL{
    _videoURL = videoURL;
    
    [self addAVPlayer];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *playerItem = object;
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            [_player play];
        }
    }
}

- (void)stopPlay{
    [_player pause];
//    [_playerItem removeObserver:self forKeyPath:@"status"];
}

- (void)dealloc{
    [_playerItem removeObserver:self forKeyPath:@"status"];
}


- (void)updatePlayerLayerFrame{
    _playerLayer.frame = self.bounds;
}


@end
