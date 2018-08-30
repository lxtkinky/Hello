//
//  TXLotteryBetHelper.m
//  HelloWorld
//
//  Created by ken on 2018/7/19.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXLotteryBetHelper.h"

@interface TXLotteryBetHelper()

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation TXLotteryBetHelper

- (void)test{
    NSArray *dataArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    self.dataArr = dataArr;
    self.array = [NSMutableArray array];
    [self combine:(int)dataArr.count index:6 tem:@""];
//    for (int i = 0; i < dataArr.count; i++) {
//        [self combine:(int)dataArr.count index:i + 1 tem:@""];
//    }
}

- (NSInteger)betNumArray:(NSArray *)totalArr kNum:(int)k{
    self.dataArr = totalArr;
    self.array = [NSMutableArray array];
    [self combine:(int)self.dataArr.count index:6 tem:@""];
    return self.array.count;
}

- (void)combine:(int)n index:(int)k tem:(NSString *)str{
    for (int i = n; i >= k; i--) {
        if (k > 1) {
            [self combine:i-1 index:k-1 tem:[NSString stringWithFormat:@"%@%@", str, [_dataArr objectAtIndex:i -1]]];
        }else{
            NSString *string = [NSString stringWithFormat:@"%@%@", str, [_dataArr objectAtIndex:i -1]];
            NSLog(@"string = %@", string);
            [self.array addObject:string];
        }
    }
}

//- (void)test{
//
//    NSArray * dataArr = @[@"1",@"2",@"3",@"4",@"5",@"6"];
//
//    for (int i = 0; i < dataArr.count; i++)
//    {
//        [self combine:(int)dataArr.count index:i + 1 temp:@""];
//
//
//}

//- (void)combine:(int)n index:(int)k temp:(NSString *)str
//    {
//        for(int i = n; i >= k; i--)
//        {
//            if(k > 1)
//            {
//                [self combine:i-1 index:k-1 temp:[NSString stringWithFormat:@"%@%@",str,[dataArr objectAtIndex:i-1]]];
//            }
//            else
//            {
//                NSLog(@"%@",[NSString stringWithFormat:@"%@%@",str,[dataArr objectAtIndex:i-1]]);
//            }
//}


@end
