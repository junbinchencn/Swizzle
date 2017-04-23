//
//  Son.m
//  Swizzle
//
//  Created by junbin on 17/4/23.
//  Copyright © 2017年 junbinchen. All rights reserved.
//

#import "Son.h"
#import "NSObject+MethodSwizzle.h"
@implementation Son

typedef void (*voidIMP)(id,SEL,...);
static voidIMP sonOrigAddObserver = NULL;



// 用于替换 NSNotificationCenter 的 addObserver:selector:name:object: 的默认实现
static void MyAddObserver(id self,SEL _cmd,NSString *someThing){
    NSAssert(sonOrigAddObserver, @"旧方法找不到");
    NSLog(@"Son someThing");
    if(sonOrigAddObserver){
        sonOrigAddObserver(self,_cmd,someThing);
    }
}

+ (void)swizzleAddObserver{
    NSAssert(!sonOrigAddObserver, @"swizzleAddObserver 只能调用一次");
    // 准备混写的方法
    SEL sel = @selector(doSomeThing:);
    // 替换方法实现
    sonOrigAddObserver = (void *)[self swizzleSelector:sel withIMP:(IMP)MyAddObserver];
}

@end
