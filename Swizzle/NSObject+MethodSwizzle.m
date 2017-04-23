//
//  NSObject+MethodSwizzle.m
//  Swizzle
//
//  Created by junbin on 17/4/22.
//  Copyright © 2017年 junbinchen. All rights reserved.
//

#import "NSObject+MethodSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (MethodSwizzle)

// 把 origSelector 的当前实现替换为新的实现
+(IMP)swizzleSelector:(SEL)origSelector withIMP:(IMP)newIMP{
    // 当前 class
    Class class = [self class];
    // 获取 origSelector 的 Method
    Method origMethod = class_getInstanceMethod(class, origSelector);
    // 获取 origSelector 的实现
    IMP origIMP = method_getImplementation(origMethod);

    // 若是 class_addMethod 给 class 成功添加了方法，那么返回 YES，否则返回 NO。
    // class_addMethod 会覆盖父类的方法实现，若是覆写方法会返回 YES。
    // class_addMethod 返回 NO，那么我们可以知道这个类是直接实现了 origSelector 对应的方法
    BOOL isAdd = class_addMethod(class, origSelector, newIMP, method_getTypeEncoding(origMethod));
    if (!isAdd) {
        // 替换 origMethod 方法的实现
        method_setImplementation(origMethod, newIMP);
    }
    // 返回 origSelector 对应的方法的实现
    return origIMP;
}

@end
