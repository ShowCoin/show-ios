//
//  UIView+SLComOpenThreadOTScreenshotHelperStatusBarReference.m
//  ShowLive
//
//  Created by showgx on 2018/5/30.
//  Copyright © 2018年 vning. All rights reserved.
//
static UIView *statusBarInstance = nil;

#import "SLComOpenThreadOTScreenshotHelperSwizzleHelper.h"
#import "UIView+SLComOpenThreadOTScreenshotHelperStatusBarReference.h"

@implementation UIView (SLComOpenThreadOTScreenshotHelperStatusBarReference)

+ (UIView *)statusBarInstance_ComOpenThreadOTScreenshotHelper
{
    return statusBarInstance;
}


@end
