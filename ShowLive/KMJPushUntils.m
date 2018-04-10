//
//  KMJPushUntils.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "KMJPushUntils.h"
#import "JPUSHService.h"

@implementation KMJPushUntils

+(void)loginJPush{
//    [JPUSHService setAlias:UserProfile.uid completion:nil seq:0];
//    NSLog(@"JPUSH alias:%@", UserProfile.uid);
//    NSString *city = UserProfile.city.length >0 ? UserProfile.city: UserProfile.locationCity;
//    NSString *appVersion = [KMUtils appVersion];
//    if (city.length >0  && city != nil && appVersion.length >0 && appVersion != nil) {
//        NSMutableSet *set = [[NSMutableSet alloc] init];
//        [set addObject:city];
//        [set addObject:appVersion];
//        [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//            
//        } seq:0];
//    }
}

+(void)logoutJPush{
    [JPUSHService setAlias:@"" completion:nil seq:0];
    [JPUSHService cleanTags:nil seq:0];
}
@end
