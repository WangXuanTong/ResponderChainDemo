//
//  UIResponder+Router.m
//  ResponderChainDemo
//
//  Created by Tong on 2017/8/18.
//  Copyright © 2017年 Tong. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

- (NSInvocation *)createInvocationWithSelector:(SEL)selector
{
    NSMethodSignature *methodSignature = [self methodSignatureForSelector:selector];
   
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = self;
    invocation.selector = selector;
    
    return invocation;
}


@end
