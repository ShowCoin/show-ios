//
//  SLBaseWebViewRequestHelper.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/20.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLBaseWebViewRequestHelper.h"
static inline NSString * NSStringNoEmpty(NSString *string) {
    return string.length >0 ? string : @"";
}

@implementation SLBaseWebViewRequestHelper
+ (NSURLRequest *)requestAppendAppInfo:(NSURLRequest *)request
{
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    //  Idfa号，常用语广告推广
    [mutableRequest setValue:[KMUtils idfa] forHTTPHeaderField:@"IDFA"];
    //  Idfv号，区别于m2中的idfv，这个不用取keychain里的数据
    [mutableRequest setValue:[KMUtils idfv] forHTTPHeaderField:@"IDFY"];
    //  用户账号
    [mutableRequest setValue:NSStringNoEmpty(AccountUserInfoModel.uid) forHTTPHeaderField:@"Beke-Userid"];
    //  经度
    [mutableRequest setValue:@"" forHTTPHeaderField:@"Longitude"];
    //  纬度
    [mutableRequest setValue:@"" forHTTPHeaderField:@"Latitude"];
    //  机型
    [mutableRequest setValue:[KMUtils phoneType] forHTTPHeaderField:@"Phone-Type"];
    //  终端运营商名称
    [mutableRequest setValue:[KMUtils op] forHTTPHeaderField:@"OP"];
    //  终端所处国家
    [mutableRequest setValue:[KMUtils co] forHTTPHeaderField:@"CO"];
    //  操作系统名称
    [mutableRequest setValue:[KMUtils os] forHTTPHeaderField:@"OS"];
    //  屏幕分辨率
    [mutableRequest setValue:[KMUtils sc] forHTTPHeaderField:@"SC"];
    //  操作系统版本
    [mutableRequest setValue:[KMUtils deviceVersion] forHTTPHeaderField:@"Kernel-Version"];
    //  应用版本号，A：数字类型 I：字符串类型
    [mutableRequest setValue:[KMUtils appVersion] forHTTPHeaderField:@"App-Version"]; //
    //  应用版本名，字符串型，自定义的
    [mutableRequest setValue:[KMUtils vn] forHTTPHeaderField:@"VN"]; //
    //  联网方式
    [mutableRequest setValue:[KMUtils netType] forHTTPHeaderField:@"Net-Type"];
    //  应用日志成功发送次数，1可表示新增用户，用户卸载或重装数值最好不清空
    //    [self setValue:@"" forHTTPHeaderField:@"TT"];
    //  请求创建时间
    [mutableRequest setValue:[KMUtils time] forHTTPHeaderField:@"Time"];
    //  M2 A：md5(imei+androidId+SerialNo) I：idfv，keychain存储，保证idfv不变
    [mutableRequest setValue:[KMUtils device_uuid] forHTTPHeaderField:@"Device-Uuid"];
    //  扩展字段
    [mutableRequest setValue:@"" forHTTPHeaderField:@"TAG"];
    //  用户登录之后的token
    [mutableRequest setValue:NSStringNoEmpty(AccountUserInfoModel.token) forHTTPHeaderField:@"Beke-UserToken"];
    //  设备名称
    [mutableRequest setValue:[KMUtils deviceName] forHTTPHeaderField:@"Device-Name"];
    //  电话号码
    [mutableRequest setValue:NSStringNoEmpty(AccountUserInfoModel.phoneNumber) forHTTPHeaderField:@"Phone-Number"];
    //  推送id
    [mutableRequest setValue:NSStringNoEmpty(AccountUserInfoModel.uid) forHTTPHeaderField:@"Push-Id"];
    // MAC地址，仅对WIFI连接时有效
    [mutableRequest setValue:[KMUtils mac] forHTTPHeaderField:@"MAC"];
    // IMEI串号
    [mutableRequest setValue:[KMUtils im] forHTTPHeaderField:@"IM"];
    // 渠道号，A区别不同渠道包；I无法分包，需要另行计算
    [mutableRequest setValue:[KMUtils channel] forHTTPHeaderField:@"Channel"];
    //  所在城市
    [mutableRequest setValue:[NSStringNoEmpty(AccountUserInfoModel.city) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forHTTPHeaderField:@"City"];
    // Content-Type
    [mutableRequest setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    return [mutableRequest copy];
}

@end

