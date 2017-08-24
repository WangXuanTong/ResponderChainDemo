//
//  UIResponder+Router.h
//  ResponderChainDemo
//
//  Created by Tong on 2017/8/18.
//  Copyright © 2017年 Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

- (NSInvocation *)createInvocationWithSelector:(SEL)selector;

@end
