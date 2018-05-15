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
@property (nonatomic, strong) NSString *name;

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
    
    [self threadBlock];
    
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

/**
 线程销毁的两种情况
 1、主动效果，调用exit
 2、被动销毁，线程没有任务了，线程就会自动退出
 */
- (void)threadBlock{
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        int i = 0;
        
        while (true) {
            i++;
            NSLog(@"%ld", i);
            if (i > 100000) {
                
//                exit(0);
            }
        }
    }];
    [thread start];
}

- (void)startOperation{
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation");
    }];
    
    
    [operation1 start];
    
    [NSBlockOperation blockOperationWithBlock:^{
        
    }];
    
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invokeMethod) object:nil];
    [operation2 start];
}

- (void)invokeMethod{
    NSLog(@"NSInvocationOperation");
}

- (void)GCDTimer{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 1.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"GCD timer");
    });
    dispatch_resume(timer);
}

- (void)startGCD{
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t queue2 =  ("queue2", DISPATCH_QUEUE_CONCURRENT);

    
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
