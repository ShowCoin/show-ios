//
//  UIWindow+JKHierarchy.m
//
//  Created by Jakey on 15/1/16.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIWindow+JKHierarchy.h"

@implementation UIWindow (JKHierarchy)
- (UIViewController*)jk_topMostController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}


@end
