//
//  TXAudioController.m
//  HelloWorld
//
//  Created by ken on 2018/5/10.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXAudioController.h"
#import <AVFoundation/AVFoundation.h>

@interface TXAudioController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TXAudioController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"turntable_tur_bk"]];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(362, 362));
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"play" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self playAudio];
    }];
}

static  SystemSoundID soundID = 0;
- (void)playAudio{
    
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"9939" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:audioPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    
//    //播放声音
//    AudioServicesPlaySystemSoundWithCompletion(soundID, ^{
//        NSLog(@"播放完成");
//    });
    
    //带振动的音效播放
    AudioServicesPlayAlertSoundWithCompletion(soundID, ^{
        NSLog(@"播放完成！");
    });
}

- (void)stopPlayAudio{
    AudioServicesDisposeSystemSoundID(soundID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
