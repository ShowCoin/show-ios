//
//  SLInviteCacheModel.m
//  ShowLive
//
//  Created by chenyh on 2018/9/7.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLInviteCacheModel.h"

static NSString * const kSLInviteCacheModelKey = @"kSLInviteCacheModelKey";

@interface SLInviteCacheModel ()

@end

@implementation SLInviteCacheModel

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (NSArray *)ignoreArrary{
    return @[@"existAction"];
}

@end
