//
//  GCDViewController.m
//  HelloWorld
//
//  Created by test on 2018/1/11.
//  Copyright © 2018年 test. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.button];
    self.button.backgroundColor = RGBCOLOR(252, 222, 111);
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"start" forState:UIControlStateNormal];
        WeakSelf
        _button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            [weakSelf startGCD];
            [weakSelf startOperation];
            return [RACSignal empty];
        }];
    }
    
    return _button;
}

- (void)startOperation{
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation");
    }];
    [operation1 start];
    
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invokeMethod) object:nil];
    [operation2 start];
}

- (void)invokeMethod{
    NSLog(@"NSInvocationOperation");
}

- (void)startGCD{
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);

    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue1, ^{
        
        sleep(3);
        NSLog(@"我是queue1-%@", [NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue2, ^{
        
        sleep(5);
        NSLog(@"我是queue2-%@", [NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"两个操作都完成!-%@", [NSThread currentThread]);
        
        dispatch_group_enter(group);
        dispatch_group_async(group, queue1, ^{
            sleep(3);
            NSLog(@"第二次使用queue1-%@", [NSThread currentThread]);
            dispatch_group_leave(group);
        });
        
        dispatch_group_enter(group);
        dispatch_group_async(group, queue2, ^{
            sleep(5);
            NSLog(@"第二次使用queue2-%@", [NSThread currentThread]);
            dispatch_group_leave(group);
        });
        
        dispatch_group_notify(group, queue1, ^{
            
            NSLog(@"第二次任务完成!-%@", [NSThread currentThread]);
        });
    });
}


@end
