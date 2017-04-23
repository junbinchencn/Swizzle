//
//  ViewController.m
//  Swizzle
//
//  Created by junbin on 17/4/22.
//  Copyright © 2017年 junbinchen. All rights reserved.
//

#import "ViewController.h"
#import "NSNotificationCenter+MethodSwizzle.h"
#import "Son.h"

@interface Observer : NSObject
@end

@implementation Observer

- (void)somthingHappened:(NSNotification*)note {
    NSLog(@"Something happened");
}
@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载方法混写
    [NSNotificationCenter swizzleAddObserver];
    // 给 NSNotificationCenter 添加一个观察者
    Observer *observer = [[Observer alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:@selector(somthingHappened:)
                                                 name:@"SomethingHappenedNotification"
                                               object:nil];

    
    // 用于验证 class_addMethod 的方法已存在于父类中，class_addMethod 的返回值
//    [Son swizzleAddObserver];
//    Son  *son  = [[Son alloc] init];
//    [son doSomeThing:@"call father"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
