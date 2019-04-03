//
//  TXStaticController.h
//  HelloWorld
//
//  Created by HUIDUOLA on 2019/4/1.
//  Copyright © 2019 Sheng Yuan Technology. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

//NSString *userName;       //无法被外部文件使用 编译会报错

static NSString *userName;  //可以w被外部文件使用

static int testStaticFunc;

extern NSString *const author;  //外部连接
//extern const NSString *author;  //改变了author的声明方式所以可以修改

@interface TXStaticController : BaseViewController

- (int)testStaticFunc;

@end

NS_ASSUME_NONNULL_END
