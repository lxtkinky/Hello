//
//  TXVipVideoController.m
//  HelloWorld
//
//  Created by lixt on 2018/3/27.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXVipVideoController.h"

@interface TXVipVideoController ()

@end

@implementation TXVipVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initVipURLs];
}

- (void)initVipURLs{
    
    NSURL *url = [NSURL URLWithString:@"https://iodefog.github.io/text/viplist.json"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response,
                                               NSData * _Nullable data,
                                               NSError * _Nullable connectionError) {
                               if(!connectionError){
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                   NSLog(@"%@",dict);
//                                   [self transformJsonToModel:dict[@"list"]];
//                                   [self transformPlatformJsonToModel:dict[@"platformlist"]];
//
//                                   [[NSNotificationCenter defaultCenter] postNotificationName:KHLVipVideoRequestSuccess object:nil];
                               }else {
                                   NSLog(@"connectionError = %@",connectionError);
                               }
                           }];
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
