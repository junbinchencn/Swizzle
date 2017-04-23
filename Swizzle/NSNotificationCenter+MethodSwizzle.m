//
//  NSNotificationCenter+MethodSwizzle.m
//  Swizzle
//
//  Created by junbin on 17/4/23.
//  Copyright © 2017年 junbinchen. All rights reserved.
//

#import "NSNotificationCenter+MethodSwizzle.h"
#import "NSObject+MethodSwizzle.h"

@implementation NSNotificationCenter (MethodSwizzle)

typedef void (*voidIMP)(id,SEL,...);
static voidIMP sOrigAddObserver = NULL;

// 用于替换 NSNotificationCenter 的 addObserver:selector:name:object: 的默认实现
static void MyAddObserver(id self,SEL _cmd,id observer,SEL selector,NSString *name,id object){
    NSLog(@"添加观察者：%@",observer);
    NSAssert(sOrigAddObserver, @"旧方法找不到");
    if(sOrigAddObserver){
        sOrigAddObserver(self,_cmd,observer,selector,name,object);
    }
}

+ (void)swizzleAddObserver{
    NSAssert(!sOrigAddObserver, @"swizzleAddObserver 只能调用一次");
    // 准备混写的方法
    SEL sel = @selector(addObserver:selector:name:object:);
    // 替换方法实现
    sOrigAddObserver = (void *)[self swizzleSelector:sel withIMP:(IMP)MyAddObserver];
}

@end
