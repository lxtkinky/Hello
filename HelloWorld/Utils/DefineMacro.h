//
//  DefineMacro.h
//  HelloWorld
//
//  Created by test on 2018/1/4.
//  Copyright © 2018年 test. All rights reserved.
//

#ifndef DefineMacro_h
#define DefineMacro_h

#define WeakSelf __weak typeof(self) weakSelf = self;

#define WeakType(type) __weak typeof(type) weak##type = type;
#define StrongType(type)  __strong typeof(type) type = weak##type;


#endif /* DefineMacro_h */
