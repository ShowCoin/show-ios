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


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class statusBarClass = NSClassFromString(@"UIStatusBar");
        [SLComOpenThreadOTScreenshotHelperSwizzleHelper swizzClass:statusBarClass
                                                          selector:@selector(setFrame:)
                                                          selector:@selector(setFrameIntercept_ComOpenThreadOTScreenshotHelper:)];
        
        [SLComOpenThreadOTScreenshotHelperSwizzleHelper swizzClass:statusBarClass
                                                          selector:NSSelectorFromString(@"dealloc")
                                                          selector:@selector(deallocIntercept_ComOpenThreadOTScreenshotHelper)];
    });
}

- (void)setFrameIntercept_ComOpenThreadOTScreenshotHelper:(CGRect)frame
{
    [self setFrameIntercept_ComOpenThreadOTScreenshotHelper:frame];
    statusBarInstance = self;
}

- (void)deallocIntercept_ComOpenThreadOTScreenshotHelper
{
    statusBarInstance = nil;
    [self deallocIntercept_ComOpenThreadOTScreenshotHelper];
}

@end
