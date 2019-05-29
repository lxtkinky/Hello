//
//  UIButton+Extend.h
//  HelloWorld
//
//  Created by HUIDUOLA on 2019/4/19.
//  Copyright © 2019 Sheng Yuan Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extend)


/**
 扩大响应区域

 @param edge 上下左右响应区域
 */
- (void)expandRegion:(UIEdgeInsets)edge;

@end

NS_ASSUME_NONNULL_END
