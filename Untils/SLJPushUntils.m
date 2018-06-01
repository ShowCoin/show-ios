//
//  SLJPushUntils.m
//  ShowLive
//
//  Created by iori_chou on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLJPushUntils.h"
#import "JPUSHService.h"
@implementation SLJPushUntils
+(void)loginJPush{
    [JPUSHService setAlias:AccountUserInfoModel.uid completion:nil seq:0];
    NSLog(@"JPUSH alias:%@", AccountUserInfoModel.uid);
    NSString *city = AccountUserInfoModel.city.length >0 ? AccountUserInfoModel.city: @"";
    NSString *appVersion = [SLUtils appVersion];
    if (city.length >0  && city != nil && appVersion.length >0 && appVersion != nil) {
        NSMutableSet *set = [[NSMutableSet alloc] init];
        [set addObject:city];
        [set addObject:appVersion];
        [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
            
        } seq:0];
    }
}

+(void)logoutJPush{
    [JPUSHService setAlias:@"" completion:nil seq:0];
    [JPUSHService cleanTags:nil seq:0];
}

@end
