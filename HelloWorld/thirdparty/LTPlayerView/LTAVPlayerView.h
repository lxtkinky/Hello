//
//  LTAVPlayerView.h
//  HelloWorld
//
//  Created by test on 2017/12/25.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTAVPlayerView : UIView
/**
 设置视频播放地址
 */
- (void)setVedioURL:(NSString *)videoURL;

/**
 停止播放远程视频 
 */
- (void)stopPlay;

/**自动布局需要等到view的frame确定后更新playerlayer的frame*/
- (void)updatePlayerLayerFrame;

@end
