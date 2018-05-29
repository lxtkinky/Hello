//
//  TXGifView.m
//  HelloWorld
//
//  Created by ken on 2018/5/25.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXGifView.h"

@interface TXGifView()

@property (nonatomic, assign)CGImageSourceRef gif;
@property (nonatomic, strong)NSDictionary *gifDic;
@property (nonatomic, assign)size_t index;
@property (nonatomic, assign)size_t count;
@property (nonatomic, strong)NSTimer *timer;

@end

@implementation TXGifView

- (instancetype)initWithGif:(NSString *)gifName{
    self = [self init];
    [self createGif:gifName];
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)createGif:(NSString *)gifName{
    NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    _gifDic = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:gifName ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:filePath];
    
    _gif = CGImageSourceCreateWithData((CFDataRef)gifData, (CFDictionaryRef)_gifDic);
    _count = CGImageSourceGetCount(_gif);
    [self updateGifView];
}

- (void)startGif{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateGifView) userInfo:nil repeats:YES];
    [_timer fire];
    _animated = YES;
}

- (void)updateGifView{
    _index++;
    _index = _index % _count;
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(_gif, _index, (CFDictionaryRef)_gifDic);
    self.layer.contents = (__bridge id)imageRef;
    CFRelease(imageRef);
}


- (void)stopGif{
    _animated = NO;
    [_timer invalidate];
    _timer = nil;
}


@end
