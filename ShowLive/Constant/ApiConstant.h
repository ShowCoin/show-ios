//
//  ApiConstant.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#ifndef ApiConstant_h
#define ApiConstant_h

//HTTP服务器域名
#define kShowDevelopment 0  //线上环境与测试环境切换，此条打开即为测试环境，注释起来是线上环境

#if defined(kShowDevelopment)
//****************************************测试环境******************************************
#define MainURL Show_domain(@"")
static NSString *const kAppKey_RongCloud = @"";  //融云appkey
#define Domain_KEY @"1"
#else
//****************************************线上环境******************************************
#define MainURL Show_domain(@"")
static NSString *const kAppKey_RongCloud = @"";
#define Domain_KEY @""
#endif

static inline NSString * Show_domain(NSString *defaultDomain) {
    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:Domain_KEY];
    return domain.length >0 ?  domain: defaultDomain;
}

// 友盟 appkey
#define UM_Social_Appkey @""
// 友盟微信
#define UM_WX_AppSecret @""
#define UM_WX_RedirectURL @""
// 友盟新浪
#define UM_SINA_AppSecret @""
#define UM_SINA_RedirectURL @""

//tencent信息
#define QQ_APPID                @""
#define UM_QQ_AppSecret         @""
#define UM_QQ_RedirectURL       @"http://www.qq.com"
//--------------

// 友盟统计 appKey
#define UM_Analytics_AppKey @""

// 微信 Appid
#define WX_APPID @""
// 新浪 Appid
#define SINA_APPID @""

// JPUSH 注意NotificationService.m中没有使用appkey这个宏，如有变动需要手动替换
#define JPUSH_AppKey  @""
#define JPUSH_Channel @""
#define JPUSH_isProduction YES

// 百度
#define BAIDU_AppKey @""

//TalkingData
//AppAnalytics
#define kAppAnalyticsAppID      @""
//AdTracking
#define kAdTrackingAppID        @""
//channel
#define kTalkingDataChannelID   @""
#endif /* ApiConstant_h */
