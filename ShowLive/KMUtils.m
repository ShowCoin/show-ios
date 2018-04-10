//
//  KMUtils.m
//  NetDemo
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "KMUtils.h"
#import <AdSupport/ASIdentifierManager.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
//#import "KMKeyChainManager.h"
//#import "KMUserDefaultManager.h"
#import <sys/utsname.h>
#import <ARKit/ARKit.h>

@implementation KMUtils

#pragma mark - 手机号处理
+ (NSString*)formatePhoneNumber:(NSString*)phoneNumber
{
    if (!phoneNumber)
        return nil;
    NSRange range=[phoneNumber rangeOfString:@"*86"];
    if (range.location==0&&range.length==3) {//手机卫士Appstore版本加的号码过滤
        return nil;
    }
    NSString* _phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [phoneNumber length])];
    NSString* mobilePhoneNumber = nil;
    if([_phoneNumber length] > 10)
    {
        unichar c = [_phoneNumber characterAtIndex:[_phoneNumber length] - 11];
        if(c == '1')
        {
            mobilePhoneNumber = [_phoneNumber substringWithRange:NSMakeRange([_phoneNumber length] - 11, 11)];
        }
    }
    return mobilePhoneNumber;
}

#pragma mark - 设备ID
+ (NSString *)deviceID {
    NSString *deviceID = @"";
    if (!deviceID) {
        deviceID = [self _generateDeviceID];
    }
    return deviceID;
}

#pragma mark - IDFA
+(NSString *)idfa{
    NSString *identifierForAdvertising = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return identifierForAdvertising;
}

#pragma mark - IDFV
+(NSString *)idfv{
    NSString *idfv = @"";
    if (idfv.length == 0) {
        idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        if (idfv == nil) {
            idfv = @"simulator";
        }
    }
    return idfv;
}

#pragma mark - 机型
+(NSString *)phoneType{
    return [[UIDevice currentDevice] model];
}

#pragma mark - 终端运营商名称
+(NSString *)op{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentCountry= [[telephonyInfo subscriberCellularProvider] carrierName];
    if([currentCountry isEqualToString:@"中国移动"]){
        return  @"1";
    }else if([currentCountry isEqualToString:@"中国联通"]){
        return  @"2";
    }else if([currentCountry isEqualToString:@"中国电信"]){
        return  @"3";
    }else{
        return  @"";
    }
}
#pragma mark - 终端所处国家
#warning 写死 需要修改
+(NSString *)co{
    return @"china";
}

#pragma mark - 操作系统名称
+(NSString *)os{
    return [UIDevice currentDevice].systemName;
}

#pragma mark - 屏幕分辨率
+(NSString *)sc{
    return [NSString stringWithFormat:@"%f*%f",kScreenWidth * kScreenScale, kScreenHeight * kScreenScale];
}

#pragma mark - 操作系统版本
+(NSString *)deviceVersion{
    return [UIDevice currentDevice].systemVersion;
}

#pragma mark - 应用版本号
+(NSString *)appVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark - 应用版本名
+(NSString *)vn{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark - 联网方式
+(NSString *)netType{
    return  @"1";
}

#pragma mark - 应用日志成功发送次数，1可表示新增用户，用户卸载或重装数值最好不清空
+(NSString *)tt{
    return @"";
}

#pragma mark - 请求创建时间
+(NSString *)time{
    NSTimeZone* zone = [NSTimeZone timeZoneWithName:@"Asia/BeiJing"];
    NSTimeInterval delta = [zone secondsFromGMTForDate:[NSDate date]];
    NSString *string = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] + delta];
    double a = [string doubleValue];
    NSString * dateString = [NSString stringWithFormat:@"%f",a];
    return  [[dateString componentsSeparatedByString:@"."]objectAtIndex:0];
}

#pragma mark - I：idfv，keychain存储，保证idfv不变
+(NSString *)device_uuid{
    return [self idfv];
}

#pragma  mark - 设备名称
+(NSString *)deviceName{
    return [[UIDevice currentDevice].name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


#pragma mark - private
+ (NSString *)_generateDeviceID {
    NSString *deviceID = [NSUUID UUID].UUIDString;
    return deviceID;
}

+(NSString *)channel{
    return @"iOS";
}

+(NSString *)mac{
    return @"02:00:00:00:00:00";
}

+(NSString *)im{
    return @"";
}

+(NSString *)deviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    if([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    if([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    if([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    if([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    if([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    if([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    if([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    if([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    if([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    if([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    if([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    if([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    if([platform isEqualToString:@"iPad4,7"]) return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,8"]) return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,9"]) return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad5,1"]) return @"iPad Mini 4";
    if([platform isEqualToString:@"iPad5,2"]) return @"iPad Mini 4";
    if([platform isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if([platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if([platform isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    if([platform isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";
    if([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    if([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    return platform;
}

+(BOOL)isSupportARKit{
    BOOL support = NO;
    if (@available(iOS 11.0, *)) {
        support = [ARConfiguration isSupported];
    }
    NSLog(@"是否支持 %@" ,support == YES ? @"YES" : @"NO");
    return support;
}
@end
