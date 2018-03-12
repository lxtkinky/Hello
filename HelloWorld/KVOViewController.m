//
//  KVOViewController.m
//  HelloWorld
//
//  Created by test on 2018/1/4.
//  Copyright © 2018年 test. All rights reserved.
//

#import "KVOViewController.h"
#import "Person.h"
#import "NSObject+Runtime.h"


static NSString *keyPath = @"name";

@interface KVOViewController ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) Person *person;
@property (nonatomic) NSInteger age;

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
    
//    NSLog(@"%p", @"11");
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i < 10; i++) {
//        [array addObject:@"11"];
//    }
//    NSLog(@"==========");
    
    [self observePerson];

//    [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];

}

- (void)observePerson{
    Person *person = [[Person alloc] init];
    person.array = [NSMutableArray arrayWithCapacity:0];
    _person = person;
    [person addObserver:self forKeyPath:@"array" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
//    [person tx_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
//    [person tx_addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@-->%@",change, self.person.array);
//    if ([object isEqual:self]) {
//        NSLog(@"name changed %@-->%@", [change objectForKey:NSKeyValueChangeOldKey], [change objectForKey:NSKeyValueChangeNewKey]);
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.person.age = ++_age;
//    self.person.name = [NSString stringWithFormat:@"lxt%ld", _age];
    
    //通过赋值的方式才能观察到array的变化，直接操作array无法观察到array的变化
    /*
    static NSMutableArray *array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = [NSMutableArray array];
    });
    [array addObject:@"1111"];
    self.person.array = array;
     */
    
    //想要观察到array的变化 必须通过KVC的方式获取到array 然后再进行操作
    NSMutableArray *tempArray = [self.person mutableArrayValueForKey:@"array"];
    [tempArray addObject:@"1111"];
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
