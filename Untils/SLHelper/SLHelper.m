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
+ (NSDate*)dateOfFileCreateWithFolderName:(NSString *)folderName cacheName:(NSString *)cacheName
{
    NSString *folder = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:folderName];
    NSString *filePath = [folder stringByAppendingPathComponent:cacheName];
    NSError *error;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
    
    if(!error) {
        return [attributes objectForKey:NSFileCreationDate];
    }
    
    return nil;
}

+ (long long)sizeOfFolder:(NSString*)folderPath {
    NSError *error;
    NSArray *contents = [[NSFileManager defaultManager] subpathsAtPath:folderPath];
    NSEnumerator *enumerator = [contents objectEnumerator];
    long long totalFileSize = 0;
    
    NSString *path = nil;
    while (path = [enumerator nextObject]) {
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:path] error:&error];
        totalFileSize += [attributes fileSize];
    }
    
    return totalFileSize;
}
+ (void)removeContentsOfFolder:(NSString *)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager subpathsAtPath:folderPath];
    NSEnumerator *enumerator = [contents objectEnumerator];
    
    NSString *file;
    while (file = [enumerator nextObject]) {
        NSString *path = [folderPath stringByAppendingPathComponent:file];
        [fileManager removeItemAtPath:path error:nil];
    }
}
+ (void) deleteContentsOfFolder:(NSString *)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:folderPath error:nil];
    
    
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
+ (NSInteger)getUrlSchemesIndex:(NSString*)URLString  {
    NSInteger index = -1;
    NSArray *schemesArray;
    schemesArray = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    if ([schemesArray count] > 0) {
        NSDictionary *dic = [schemesArray objectAtIndex:0];
        schemesArray = [dic objectForKey:@"CFBundleURLSchemes"];
        int i = 0;
        for (NSString *schemesName in schemesArray) {
            if([URLString rangeOfString:schemesName].location != NSNotFound){
                return index = i;
            }
            i ++;
        }
    }
    
    return index;
}

#pragma mark phone number
/**
 *    @brief    判断是不是电话号码
 *
 *    @return     bool
 */
+(BOOL) isPhoneNumber:(NSString*) number
{
    NSString *str = @"^((0\\d{2,3}-\\d{7,8})|(1[3458]\\d{9}))$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (([regextestmobile evaluateWithObject:number] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

+(BOOL) isPostalcode:(NSString*) code{
    
    NSString *str = @"^[0-9]\\d{5}$";
    NSPredicate *regextestPostalcode = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (([regextestPostalcode evaluateWithObject:code] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

/** 是否为数字字符串 */
+ (BOOL)isPositiveNumber:(NSString *)numStr{
    NSString *regexStr = @"\\d+|\\d+\\.\\d+|\\.\\d+|\\d+.";
    NSPredicate *regextestPostalcode = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    if (([regextestPostalcode evaluateWithObject:numStr] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL) isBlankString:(NSString *)string {
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark alert
+ (CGFloat)widthForLabelWithString:(NSString *)labelString withFontSize:(CGFloat)fontsize withWidth:(CGFloat)width withHeight:(CGFloat)height
{
    if(labelString.length == 0){
        return 0.0;
    }
    
    if ([UIDevice currentDevice].systemVersion.doubleValue <= 7.0) {
        CGSize maximumLabelSize = CGSizeMake(width,height);
        CGSize expectedLabelSize = [labelString sizeWithFont:[UIFont systemFontOfSize:fontsize]
                                           constrainedToSize:maximumLabelSize
                                               lineBreakMode:0];
        
        return (expectedLabelSize.width);
    } else {
        CGSize size = CGSizeMake(width, height);
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontsize],NSFontAttributeName,nil];
        CGSize actualsize = [labelString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
        
        //得到的宽度为0，返回最大宽度
        if(actualsize.width == 0){
            return width;
        }
        
        return actualsize.width;
    }
}

+ (CGFloat)heightForLabelWithString:(NSString *)labelString withFontSize:(CGFloat)fontsize withWidth:(CGFloat)width withHeight:(CGFloat)height {
    
    if ([UIDevice currentDevice].systemVersion.doubleValue <= 7.0) {
        CGSize maximumLabelSize = CGSizeMake(width, height);
        CGSize expectedLabelSize = [labelString sizeWithFont:[UIFont systemFontOfSize:fontsize]
                                           constrainedToSize:maximumLabelSize
                                               lineBreakMode:0];
        
        return (int)(expectedLabelSize.height);
    } else {
        CGSize size = CGSizeMake(width, height);
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontsize],NSFontAttributeName,nil];
        CGSize actualsize = [labelString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
        return actualsize.height;
    }
}

@end
