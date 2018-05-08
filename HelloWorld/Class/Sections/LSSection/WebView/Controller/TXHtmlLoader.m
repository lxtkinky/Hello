//
//  TXHtmlLoader.m
//  HelloWorld
//
//  Created by ken on 2018/5/5.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXHtmlLoader.h"

@implementation TXHtmlLoader

+ (NSString *)loadHtmlStrFromFile:(NSString *)fileName{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Document" ofType:@"html"];
    NSString *htmlStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", htmlStr);
    return htmlStr;
}

@end
