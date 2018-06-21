//
//  SLHelper.m
//  ShowLive
//
//  Created by iori_chou on 2018/2/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLHelper.h"
#include <sys/utsname.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <objc/runtime.h>
#import  <CommonCrypto/CommonCryptor.h>
#import <EventKit/EventKit.h>
#import <AdSupport/ASIdentifierManager.h>

@implementation SLHelper
#pragma mark 一些常用的公共方法


/**
 *	@brief	获取当前时间戳
 *
 *	@return	 当前时间戳
 */
+(NSString *)getTimeStamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

+ (UIImage *)imageAtApplicationDirectoryWithName:(NSString *)fileName {
    if(fileName) {
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[fileName stringByDeletingPathExtension]];
        path = [NSString stringWithFormat:@"%@@2x.%@",path,[fileName pathExtension]];
        if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            path = nil;
        }
        
        if(!path) {
            path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        }
        return [UIImage imageWithContentsOfFile:path];
    }
    return nil;
}

+ (NSString *)jsonStringFromObject:(id)object{
    if([NSJSONSerialization isValidJSONObject:object]){
        NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return @"";
}

+ (NSDictionary *)dictionaryWithJSON:(id)json
{
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        NSError* error;
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if ([json isKindOfClass:[NSString class]]) {
                dic = [(NSString *)json mj_JSONObject];
            } else if ([json isKindOfClass:[NSData class]]) {
                dic = [(NSData*)json mj_JSONObject];
            }
        }
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}

+ (id)valueForKey:(NSString *)key object:(NSDictionary *)object{
    if([object isKindOfClass:[NSDictionary class]]){
        return [object objectForKey:key];
    }
    return nil;
}

/**
 *    @brief  获取用户的ADFA
 *
 */
+ (NSString *) getAdvertisingIdentifier

{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

/**
 *    @brief 获取当前设备类型如ipod，iphone，ipad
 *
 */
+ (NSString *)deviceType {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

/**
 *    @brief 获取当前设备ios版本号
 *
 */
+(float) getCurrentDeviceVersion{
    
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

/**
 *    @brief 操作系统版本号
 *
 */
+ (NSString *)iOSVersion {
    return [[UIDevice currentDevice] systemVersion];
}

#pragma 正则匹配用户密码6-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^[0-9a-zA-Z_#]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}
// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //NSString *str = @"^13\\d{9}|14[57]\\d{8}|15[012356789]\\d{8}|18\\d{9}$";
    //增加170字段判断
    NSString *str = @"^13\\d{9}|14[57]\\d{8}|15[012356789]\\d{8}|18\\d{9}|17\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

/**
 @brief 通过正则表达式判断是合法昵称
 */
+ (BOOL)isAvailableName:(NSString *)name{
    //    NSString *str = @"^(?!_)[\\w_\\u4e00-\\u9fa5\\ud83c\\udc00-\\ud83c\\udfff\\ud83d\\udc00-\\ud83d\\udfff\\u2600-\\u27ff]{2,8}$";
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    //    if (([regextestmobile evaluateWithObject:name] == YES)) {
    //        return YES;
    //    } else {
    //        return NO;
    //    }
    if (name.length>8) {
        return NO;
    }else{
        return YES;
    }
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (BOOL)createFolder:(NSString*)folderPath isDirectory:(BOOL)isDirectory {
    NSString *path = nil;
    if(isDirectory) {
        path = folderPath;
    } else {
        path = [folderPath stringByDeletingLastPathComponent];
    }
    
    if(folderPath && [[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        NSError *error = nil;
        BOOL ret;
        
        ret = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                        withIntermediateDirectories:YES
                                                         attributes:nil
                                                              error:&error];
        if(!ret && error) {
            NSLog(@"create folder failed at path '%@',error:%@,%@",folderPath,[error localizedDescription],[error localizedFailureReason]);
            return NO;
        }
    }
    
    return YES;
}

+ (NSString*)getPathInUserDocument:(NSString*) aPath{
    NSString *fullPath = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([paths count] > 0)
    {
        fullPath = (NSString *)[paths objectAtIndex:0];
        if(aPath != nil && [aPath compare:@""] != NSOrderedSame)
        {
            fullPath = [fullPath stringByAppendingPathComponent:aPath];
        }
    }
    
    return fullPath;
}

+ (NSString *)formatFileSize:(long long)fileSize {
    float size = fileSize;
    //    if (fileSize < 1023) {
    //        return([NSString stringWithFormat:@"%i bytes",fileSize]);
    //    }
    
    size = size / 1024.0f;
    if (size < 1023) {
        return([NSString stringWithFormat:@"%1.2f KB",size]);
    }
    
    size = size / 1024.0f;
    if (size < 1023) {
        return([NSString stringWithFormat:@"%1.2f MB",size]);
    }
    
    size = size / 1024.0f;
    return [NSString stringWithFormat:@"%1.2f GB",size];
}
+ (int)sizeOfFile:(NSString *)path {
    NSError *error;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
    
    if(!error) {
        return (int)[attributes fileSize];
    }
    
    return 0;
}


@end
