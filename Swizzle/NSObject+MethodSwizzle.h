//
//  NSObject+MethodSwizzle.h
//  Swizzle
//
//  Created by junbin on 17/4/22.
//  Copyright © 2017年 junbinchen. All rights reserved.
//

#import <Foundation/Foundation.h>
// 为 NSObject 添加方法混写实现
@interface NSObject (MethodSwizzle)
+ (IMP)swizzleSelector:(SEL)origSelector withIMP:(IMP)newIMP;
@end
