//
//  NSNotificationCenter+MethodSwizzle.h
//  Swizzle
//
//  Created by junbin on 17/4/23.
//  Copyright © 2017年 junbinchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (MethodSwizzle)
// 给自己添加方法混写
+ (void)swizzleAddObserver;
@end
