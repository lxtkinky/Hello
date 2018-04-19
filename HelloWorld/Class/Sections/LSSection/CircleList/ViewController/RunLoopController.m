//
//  RunLoopController.m
//  HelloWorld
//
//  Created by lixt on 2018/4/3.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "RunLoopController.h"
#import <sys/socket.h>
#import <objc/objc.h>

typedef void(^RunLoopBlock)();

@interface RunLoopController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *taskArr;  //任务数组

@property (nonatomic) CFRunLoopObserverRef observer;

@end

@implementation RunLoopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskArr = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(100, 0, 0, 0));
    }];
    
    
    
    [self addObserForMainRunLoop];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes); 
}



/*
 所有的图片渲染都在主线程的一次RunLoop循环里面，UI渲染也属于RunLoop的事情
 -次RunLoop循环，渲染的图片太多就会造成卡顿
 解决思路：
 让一次RunLoop循环，只给我加载一张图片
 步骤：
 1、观察（Observer）RunLoop循环
 2、一次循环，加载一张图片
 |-Cell数据源加载的图片放到数组里面
 |-RunLoop循环一次，从数组里面取出一张图片进行加载
 if (status) {
 [[NSRunLoop currentRunLoop] runUntilDate:[[NSDate date] dateByAddingTimeInterval:1]];
 }
 通过标志来控制RunLoop运行
 */

- (void)addObserForMainRunLoop{
    CFRunLoopRef mainLoop = CFRunLoopGetMain();
    //new copy create 堆区域开辟内存空间
    /*
    typedef struct {
        CFIndex    version;
        void *    info;
        const void *(*retain)(const void *info);
        void    (*release)(const void *info);
        CFStringRef    (*copyDescription)(const void *info);
    } CFRunLoopObserverContext;
     */
    

    CFRunLoopObserverContext context = {
        0,
        (__bridge void*)self,
        CFRetain,
        CFRelease,
        NULL
    };
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &runloopCallback, &context);
    _observer = observer;
    CFRunLoopAddObserver(mainLoop, observer, kCFRunLoopCommonModes);
    CFRelease(observer);        //释放Observer
    
}

void runloopCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
//    NSLog(@"%@", info);
    RunLoopController *vc = (__bridge RunLoopController *)info;
    if (vc.taskArr.count == 0) {
        return;
    }
    
    RunLoopBlock task = [vc.taskArr firstObject];
    task();
    [vc.taskArr removeObjectAtIndex:0];
}
- (void)addTask:(RunLoopBlock)runLoopBlock{
    [self.taskArr addObject:runLoopBlock];
    NSLog(@"array count %ld", self.taskArr.count);
    if (self.taskArr.count > 21) {
        [self.taskArr removeObjectAtIndex:0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor redColor];
        
//        [self addTask:^{
//            [RunLoopController loadImage:imageView];
//        }];
         [RunLoopController loadImage:imageView];
        
        [array addObject:imageView];
        [cell.contentView addSubview:imageView];
    }
    
    for (int i = 0; i < array.count; i++) {
        UIImageView *imageView = [array objectAtIndex:i];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(cell.contentView).with.offset(5);
            }
            else{
                UIImageView *preView = [array objectAtIndex: i - 1];
                make.left.equalTo(preView.mas_right).with.offset(5);
                make.width.equalTo(preView);
            }
            
            make.top.equalTo(cell.contentView).with.offset(5);
            make.bottom.equalTo(cell.contentView).with.offset(-5);
            
            if (i == array.count -1) {
                make.right.equalTo(cell.contentView).with.offset(-5);
            }
        }];
    }
    
    return cell;
}

+ (void)loadImage:(UIImageView *)imageView{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"meinv" ofType:@"jpg"];
    imageView.image = [[UIImage alloc] initWithContentsOfFile:imagePath];
}

//- (void)dealloc{
//
//}

@end
