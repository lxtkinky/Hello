//
//  TXGifView.h
//  HelloWorld
//
//  Created by ken on 2018/5/25.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXGifView : UIView

@property (nonatomic) BOOL animated;

- (instancetype)initWithGif:(NSString *)gifName;

- (void)startGif;

/**
 *停止动画，在退出页面之前必须调用，否则可能导致内存泄漏
 */
- (void)stopGif;

@end
