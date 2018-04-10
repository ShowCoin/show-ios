//
//  ShowHTTPRequestSerializer.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHTTPRequestSerializer.h"
#import "ShowRequestData.h"
#import "KMUtils.h"
//#import "KMSession.h"

static inline NSString * NSStringNoEmpty(NSString *string) {
    return string.length >0 ? string : @"";
}

@implementation ShowHTTPRequestSerializer
+(instancetype)serializer{
    
    ShowHTTPRequestSerializer * requestSerializer = [super serializer];
    [requestSerializer setupHttpHeaderField];
    return requestSerializer;
}

-(void)setupHttpHeaderField{
    //  Idfa号，常用语广告推广
    [self setValue:[KMUtils idfa] forHTTPHeaderField:@"IDFA"];
    //  Idfv号，区别于m2中的idfv，这个不用取keychain里的数据
    [self setValue:[KMUtils idfv] forHTTPHeaderField:@"IDFY"];
    //  用户账号
//    [self setValue:NSStringNoEmpty(UserProfile.uid) forHTTPHeaderField:@"Beke-Userid"];
    //  经度
//    [self setValue:NSStringNoEmpty(UserProfile.cityLng) forHTTPHeaderField:@"Longitude"];
    //  纬度
//    [self setValue:NSStringNoEmpty(UserProfile.cityLat) forHTTPHeaderField:@"Latitude"];
    //  机型
    [self setValue:[KMUtils deviceModel] forHTTPHeaderField:@"Phone-Type"];
    //  终端运营商名称
    [self setValue:[KMUtils op] forHTTPHeaderField:@"OP"];
    //  终端所处国家
    [self setValue:[KMUtils co] forHTTPHeaderField:@"CO"];
    //  操作系统名称
    [self setValue:[KMUtils os] forHTTPHeaderField:@"OS"];
    //  屏幕分辨率
    [self setValue:[KMUtils sc] forHTTPHeaderField:@"SC"];
    //  操作系统版本
    [self setValue:[KMUtils deviceVersion] forHTTPHeaderField:@"Kernel-Version"];
    //  应用版本号，A：数字类型 I：字符串类型
    [self setValue:[KMUtils appVersion] forHTTPHeaderField:@"App-Version"]; //
    //  应用版本名，字符串型，自定义的
    [self setValue:[KMUtils vn] forHTTPHeaderField:@"VN"]; //
    //  联网方式
    [self setValue:[KMUtils netType] forHTTPHeaderField:@"Net-Type"];
    //  应用日志成功发送次数，1可表示新增用户，用户卸载或重装数值最好不清空
    //    [self setValue:@"" forHTTPHeaderField:@"TT"];
    //  请求创建时间
    [self setValue:[KMUtils time] forHTTPHeaderField:@"Time"];
    //  M2 A：md5(imei+androidId+SerialNo) I：idfv，keychain存储，保证idfv不变
    [self setValue:[KMUtils device_uuid] forHTTPHeaderField:@"Device-Uuid"];
    //  扩展字段
    [self setValue:@"" forHTTPHeaderField:@"TAG"];
    //  用户登录之后的token
//    [self setValue:NSStringNoEmpty(UserProfile.token) forHTTPHeaderField:@"Beke-UserToken"];
    //  设备名称
    [self setValue:[KMUtils deviceName] forHTTPHeaderField:@"Device-Name"];
    //  电话号码
//    [self setValue:NSStringNoEmpty(UserProfile.phoneNumber) forHTTPHeaderField:@"Phone-Number"];
    //  推送id
//    [self setValue:NSStringNoEmpty(UserProfile.uid) forHTTPHeaderField:@"Push-Id"];
    // MAC地址，仅对WIFI连接时有效
    [self setValue:[KMUtils mac] forHTTPHeaderField:@"MAC"];
    // IMEI串号
    [self setValue:[KMUtils im] forHTTPHeaderField:@"IM"];
    // 渠道号，A区别不同渠道包；I无法分包，需要另行计算
    [self setValue:[KMUtils channel] forHTTPHeaderField:@"Channel"];
    //  所在城市
//    [self setValue:[NSStringNoEmpty(UserProfile.locationCity) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forHTTPHeaderField:@"City"];
    // Content-Type
    [self setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
}
@end
