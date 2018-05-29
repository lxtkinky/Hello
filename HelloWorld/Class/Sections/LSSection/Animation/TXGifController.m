//
//  TXGifController.m
//  HelloWorld
//
//  Created by ken on 2018/5/25.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXGifController.h"
#import "TXGifView.h"

@interface TXGifController ()

@property (nonatomic, strong)NSMutableArray<UIImage *> *images;
//@property (nonatomic, strong)GifLoadingView *loading;
@property (nonatomic, strong)UIView *gifContentView;

@property (nonatomic, assign)CGImageSourceRef gif;
@property (nonatomic, strong)NSDictionary *gifDic;
@property (nonatomic, assign)size_t index;
@property (nonatomic, assign)size_t count;
@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, strong) TXGifView *gifView;


@end

@implementation TXGifController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gifView = [[TXGifView alloc] initWithGif:@"turntable"];
    [self.view addSubview:self.gifView];
    [self.gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
//    [self createGif];
    
    WS(weakSelf)
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"停止动画" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (weakSelf.gifView.animated) {
            [weakSelf.gifView stopGif];
        }
        else{
            [weakSelf.gifView startGif];
        }
    }];
}

- (void)createGif{
    NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    _gifDic = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"turntable" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:filePath];
    
    _gif = CGImageSourceCreateWithData((CFDataRef)gifData, (CFDictionaryRef)_gifDic);
    _count = CGImageSourceGetCount(_gif);
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)stopGif{
    [_timer invalidate];
    _timer = nil;
}

- (void)startAnimation{
    _index++;
    _index = _index % _count;
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(_gif, _index, (CFDictionaryRef)_gifDic);
    self.gifContentView.layer.contents = (__bridge id)imageRef;
    CFRelease(imageRef);
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
