//
//  AppDelegate+RegisterService.m
//  ShowLive
//
//  Created by 周华 on 2018/4/8.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "AppDelegate+RegisterService.h"
#import <Bugtags/Bugtags.h>

@implementation AppDelegate (RegisterService)
-(void)registerService:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [self registerBugtags];
    [IMSer registeredWthLaunchOptions:launchOptions];
    [self registerUmengSocial];
    [KMUtils isSupportARKit];
    [SysConfig requestConfig];
}
#pragma mark -  BugTags
- (void)registerBugtags{
#if !defined(DEBUG)
    BugtagsOptions *options = [[BugtagsOptions alloc] init];
    options.trackingCrashes = YES; // 具体可设置的属性请查看 Bugtags.h
    [Bugtags startWithAppKey:@""  invocationEvent:BTGInvocationEventNone  options:options];
#endif
}
#pragma mark - 友盟分享
-(void)registerUmengSocial;
{
    [[UMSocialManager defaultManager] setUmSocialAppkey:UM_Social_Appkey];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WX_APPID appSecret:UM_WX_AppSecret redirectURL:UM_WX_RedirectURL];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINA_APPID appSecret:UM_SINA_AppSecret redirectURL:UM_SINA_RedirectURL];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APPID appSecret:UM_QQ_AppSecret redirectURL:UM_QQ_RedirectURL];
}
@end
