//
//  SDWebImageController.m
//  HelloWorld
//
//  Created by test on 17/12/19.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SDWebImageController.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SDWebImageController ()

@property (nonatomic, strong) UIImageView *portraitImageView;

@end

@implementation SDWebImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //http://img2.imgtn.bdimg.com/it/u=2804743333,4167606983&fm=27&gp=0.jpg
    
    [self.view addSubview:self.portraitImageView];
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
//    self.portraitImageView.image = [UIImage imageNamed:@"11"];
    NSString *imageStr = @"http://www.wantease.com/public/upload/20171219/largeThumb/5a38b45312515.png";
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"======================%@", image);
    }];
    
}

- (void)updateViewConstraints{
    
    
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"回收controller");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIImageView *)portraitImageView{
    if (_portraitImageView == nil) {
        _portraitImageView = [[UIImageView alloc] init];
    }
    return _portraitImageView;
}

@end
