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

+ (instancetype)currentCache {
    NSData *data = [NSUserDefaults.standardUserDefaults objectForKey:kSLInviteCacheModelKey];
    SLInviteCacheModel *per = nil;
    if (data) {
        per = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } else {
        per = [[self alloc] init];
        [per resetModel];
    }
    return per;
}



@end
