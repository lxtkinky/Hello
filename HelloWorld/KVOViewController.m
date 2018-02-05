//
//  KVOViewController.m
//  HelloWorld
//
//  Created by test on 2018/1/4.
//  Copyright © 2018年 test. All rights reserved.
//

#import "KVOViewController.h"


static NSString *keyPath = @"name";

@interface KVOViewController ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIButton *button;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 60));
    }];
    

    [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([object isEqual:self]) {
        NSLog(@"name changed %@-->%@", [change objectForKey:NSKeyValueChangeOldKey], [change objectForKey:NSKeyValueChangeNewKey]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:keyPath];
}

- (void)updateName{
    [self setValue:@"lixt" forKey:keyPath];
}


- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setBackgroundColor:[UIColor colorWithRed:125/255.0 green:123/255.0 blue:0.3 alpha:1.0]];
        
        WeakType(self)
        _button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal<id> * _Nonnull(__kindof UIButton * _Nullable input) {
            [weakself updateName];
            return [RACSignal empty];
        }];
    }
    return _button;
}

@end
