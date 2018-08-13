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
+ (CGSize)sizeForLabelWithString:(NSString *)string withFont:(UIFont *)font constrainedToSize:(CGSize)size{
    if ([UIDevice currentDevice].systemVersion.doubleValue <= 7.0) {
        CGSize expectedLabelSize = [string sizeWithFont:font
                                      constrainedToSize:size
                                          lineBreakMode:0];
        
        return expectedLabelSize;
    } else {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        CGSize actualsize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
        actualsize.width = (NSInteger)(actualsize.width + 1.0);
        actualsize.height = (NSInteger)(actualsize.height + 1.0);
        return actualsize;
    }
}

+ (NSMutableAttributedString *)appendString:(NSString *)string withColor:(UIColor *)color font:(UIFont *)font lenght:(int)lenght
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range = NSMakeRange(string.length-lenght, lenght);
    [attString addAttribute:NSFontAttributeName value:font range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attString;
    
}

/**
 @pram postion(key:位置  value:长度)
 */
+(NSMutableAttributedString *)setNSStringCorlor:(NSString *)_content positon:(NSDictionary*)positionDict withColor:(UIColor*)color
{
    //    NSString *endLength = [NSString stringWithFormat:@"%d",endNum];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_content];
    for (int i=0;i<positionDict.allKeys.count;i++) {
        NSString* key = positionDict.allKeys[i];
        NSString* val = positionDict[key];
        [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange([key intValue],[val intValue])];
    }
    return str;
}

+(NSString *)getLeftTimeWithStartTime:(double)startTime endTime:(double)endTime {
    double timeInterval = endTime - startTime;
    NSInteger secondsInDay = 24*60*60;
    NSInteger day = (NSInteger)timeInterval/secondsInDay;
    //NSInteger hour = (timeInterval - day*secondsInDay)/(60*60);
    //  NSInteger mini = (timeInterval - day*secondsInDay - hour*60*60)/60;
    //    NSInteger second = timeInterval - day*secondsInDay - hour*60*60 - mini*60;
    return [NSString stringWithFormat:@"%zd天",day];
}

+ (NSString *)transformMetreToKilometre:(NSString *)meter {
    
    if ([meter isEqualToString:@""] || !meter) {
        return @"";
    }
    
    NSInteger tmpDistance = [[NSString stringWithFormat:@"%1.0f", [meter doubleValue]] intValue];
    if (0 <= tmpDistance && tmpDistance < 1000) {
        return [NSString stringWithFormat:@"%zdm",tmpDistance];
    } else if (tmpDistance <= 99000) {
        return [NSString stringWithFormat:@"%zd.%zdkm",tmpDistance/1000,(tmpDistance%1000)/100];
    }
    else{
        return @">99km";
    }
    return nil;
}

+ (NSString *)transformMetreToKilometreAccurate:(NSString *)meter
{
    if ([meter isEqualToString:@""] || !meter) {
        return @"";
    }
    
    NSInteger tmpDistance = [[NSString stringWithFormat:@"%1.0f", [meter doubleValue]] intValue];
    if (0 <= tmpDistance && tmpDistance < 1000) {
        return [NSString stringWithFormat:@"%zd",tmpDistance];
    } else if (tmpDistance <= 99000) {
        return [NSString stringWithFormat:@"%zd.%zd千",tmpDistance/1000,(tmpDistance%1000)/100];
    }
    else{
        return @">99千";
    }
    return nil;
}

+ (NSString *)transformNumbers:(NSInteger)number {
    if (number <= 0) {
        return @"0";
    }else if (number <= 9999) {
        return [NSString stringWithFormat:@"%ld", (long)number];
    } else if (number > 9999 && number <= 999999) {
        return [NSString stringWithFormat:@"%.1f万", number*0.0001];
    } else{
        return [NSString stringWithFormat:@"%.0f万", number*0.0001];
    }
    return nil;
}
+ (NSString *)transformMoney:(NSString *)string {
    if(!string || [string floatValue] == 0){
        return @"0.00";
    }else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@",###;"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[string doubleValue]]];
    }
    return @"";
}
#pragma mark -new
+ (NSDateFormatter *)dateFormatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //常用格式 @"yyyy-MM-dd HH:mm:ss"
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [dateFormatter setTimeZone:timeZone];
    return dateFormatter;
}
+ (NSString *)formatDateWithDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:format];
    NSString *result = [dateFormatter stringFromDate:date];
    
    return result;
}
+ (NSString *)formatDateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *d = [dateFormatter dateFromString:dateString];
    
    return [SLHelper formatDateWithDate:d format:format];
}
+ (NSString *)formatTimeInterval:(NSTimeInterval)timeInterval format:(NSString *)format{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [self formatDateWithDate:date format:format];
}

+ (NSDate *)dateValueWithString:(NSString *)dateStr ByFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter dateFromString:dateStr];
}
+ (NSString *)weekdayStringValue:(NSDate*)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int weekday=(int)[comps weekday];
    switch (weekday)
    {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
            
        default:
            break;
    }
    return nil;
}

+(NSString *)getTimeIntervalWithTime:(NSTimeInterval)timeInterval{
    
    NSInteger intTime = timeInterval;
    NSInteger seconds = intTime % 60;
    NSInteger minutes = (intTime / 60) % 60;
    NSInteger hours = (intTime / 3600);
    NSString *timeStr = [NSString stringWithFormat:@"%2zd小时%2zd分%2zd秒", hours, minutes, seconds];
    return timeStr;
}
/**
 *  时间补0
 *
 *  @param str str description
 *
 *  @return return value description
 */

+ (NSString *)fillZeroWithString:(NSString *)str
{
    if (str && str.length == 1)
    {
        return [NSString stringWithFormat:@"0%@",str];
    }
    return str;
}


+(NSString *)getTwoCharTimeIntervalWithTime:(NSInteger)timeInterval formatStr:(NSString *)formatStr{
    
    NSInteger seconds = labs(timeInterval % 60);
    NSString *secondStr =[self fillZeroWithString:[NSString stringWithFormat:@"%zd",seconds]];
    NSInteger minutes = labs((timeInterval / 60) % 60);
    NSString *minuteStr =[self fillZeroWithString:[NSString stringWithFormat:@"%zd",minutes]];
    NSInteger hours = timeInterval / 3600;
    NSString *hourStr =[self fillZeroWithString:[NSString stringWithFormat:@"%zd",hours]];
    NSString *timeStr;
    
    if([formatStr rangeOfString:@"天"].location !=NSNotFound){
        if(hours>=24){
            NSString *dayStr = [NSString stringWithFormat:@"%ld",hours/24];
            hourStr =[self fillZeroWithString:[NSString stringWithFormat:@"%zd",hours%24]];
            timeStr = [NSString stringWithFormat:formatStr, dayStr, hourStr, minuteStr, secondStr];
        }else{
            NSInteger lacation =[formatStr rangeOfString:@"天"].location;
            formatStr = [formatStr substringFromIndex:lacation+1];
            timeStr = [NSString stringWithFormat:formatStr, hourStr, minuteStr, secondStr];
        }
    }else{
        timeStr = [NSString stringWithFormat:formatStr, hourStr, minuteStr, secondStr];
    }
    
    return timeStr;
}
+(NSString *)trimright0:(double )param
{
    NSString *str = [NSString stringWithFormat:@"%.2lf",param];
    NSUInteger len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        //        return [NSString stringWithFormat:@"%@0", str];
        return  [str substringToIndex:[str length]-1];
    }
    else
    {
        return str;
    }
}
+ (NSData *)archiverObject:(NSObject *)object forKey:(NSString *)key {
    if(object == nil) {
        return nil;
    }
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    
    return data;
}

+ (NSObject *)unarchiverObject:(NSData *)archivedData withKey:(NSString *)key {
    if(archivedData == nil) {
        return nil;
    }
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:archivedData];
    NSObject *object = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    
    return object;
}
+(void)synchronizedToCalendarTitle:(NSString *)title location:(NSString *)location{
    //事件市场
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    //6.0及以上通过下面方式写入事件
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                    //事件保存到日历
                    
                    
                    //创建事件
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     = title;
                    event.location = location;
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    event.startDate = [[NSDate alloc]init ];
                    event.endDate   = [[NSDate alloc]init ];
                    event.allDay = YES;
                    
                    //添加提醒
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                }
            });
        }];
    }
    else
    {
        //4.0和5.0通过下述方式添加
        
        //保存日历
        EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
        event.title     = title;
        event.location = location;
        
        NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
        [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        
        event.startDate = [[NSDate alloc]init ];
        event.endDate   = [[NSDate alloc]init ];
        event.allDay = YES;
        
        
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        NSLog(@"保存成功");
        
    }
    
}
#pragma mark getValPara

+(NSString *)getValPara:(NSMutableDictionary *)dict{
    NSMutableArray *keys= [NSMutableArray arrayWithArray:[dict allKeys]];
    [keys sortUsingSelector:@selector(compare:)];
    NSMutableString *val = [NSMutableString string];
    @autoreleasepool {
        for (NSString *key in keys) {
            id v = [dict objectForKey:key];
            
            NSString *va=[NSString stringWithFormat:@"%@",[v lowercaseString]];
            
            [val appendString:va];
        }
    }
    return val;
}
#pragma mark-
+ (id)valueForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

+ (void)setValue:(id)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)friendFormatString:(NSString *)sourceStr{
    if(![sourceStr isKindOfClass:[NSString class]]){
        return nil;
    }
    //各四个字符插入一个空字符
    NSMutableString *targetStr = [NSMutableString stringWithString:sourceStr];
    for(int i = 4, k = 4; i < sourceStr.length; i += 4, k = i+1){
        [targetStr insertString:@" " atIndex:k];
    }
    return [NSString stringWithFormat:@"%@", targetStr];
}

/**
 *    @brief    将json数据转换成id
 *
 *    @param data 数据
 *
 *    @return     id类型的数据
 */
+ (id)parserJsonData:(id)jsonData{
    
    NSError *error;
    id jsonResult = nil;
    if (jsonData&&[jsonData isKindOfClass:[NSData class]])
    {
        jsonResult = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    }
    if (jsonResult != nil && error == nil)
    {
        return jsonResult;
    }else{
        // 解析错误
        return nil;
    }
}
+(NSString *)obfuscate:(NSString *)string withKey:(NSString *)key
{
    
    NSData* bytes = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    Byte  *myByte = (Byte *)[bytes bytes];
    
    NSData* keyBytes = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    Byte  *keyByte = (Byte *)[keyBytes bytes];
    
    int keyIndex = 0;
    
    for (int x = 0; x < [bytes length]; x++)
    {
        myByte[x]  = myByte[x] ^ keyByte[keyIndex];
        
        if (++keyIndex == [keyBytes length])
        {
            keyIndex = 0;
        }
    }
    
    //可以直接返回NSData
    NSData *newData = [[NSData alloc] initWithBytes:myByte length:[bytes length]];
    NSString *aString = [[NSString alloc] initWithData:newData encoding:NSUTF8StringEncoding];
    
    return aString;
    
}
+ (NSString *)DescriptionWithDate:(NSDate *)date;
{
    @try {
        //实例化一个NSDateFormatter对象
        
        NSDate * needFormatDate = date;
        NSDate * nowDate = [NSDate date];
        
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //// 再然后，把间隔的秒数折算成天数和小时数：
        
        NSString *dateStr = @"";
        
        if (time<=60) {  //// 1分钟以内的
            dateStr = @"刚刚";
        }else if(time<=60*60){  ////  一个小时以内的
            
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
            
        }else if(time<=60*60*24){   //// 在两天内的
            static NSDateFormatter *dateFormatter = nil;
            static NSDateFormatter *dateFormatter_hhmm = nil;
            
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"YYYY-MM-dd"];
                dateFormatter_hhmm = [[NSDateFormatter alloc] init];
                [dateFormatter_hhmm setDateFormat:@"HH:mm"];
            });
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"%@",[dateFormatter_hhmm stringFromDate:needFormatDate]];
            }else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter_hhmm stringFromDate:needFormatDate]];
            }

        }
        else {
            static NSDateFormatter *dateFormatter = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy"];
            });
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                static NSDateFormatter *dateFormatter_1 = nil;
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    dateFormatter_1 = [[NSDateFormatter alloc] init];
                    [dateFormatter_1 setDateFormat:@"MM月dd日 HH:mm"];
                });
                dateStr = [dateFormatter_1 stringFromDate:needFormatDate];
            }else{
                static NSDateFormatter *dateFormatter_2 = nil;
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    dateFormatter_2 = [[NSDateFormatter alloc] init];
                    [dateFormatter_2 setDateFormat:@"yyyy-MM-dd HH:mm"];
                });
                dateStr = [dateFormatter_2 stringFromDate:needFormatDate];
            }
        }
        return dateStr;
    }
        @catch (NSException *exception) {
        return @"";
    }
}

//单个文件的大小

- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        
    }
    
    return 0;
    
}
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0*1024.0);
    
}

+ (NSString *) compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];//:ss.SSS
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

+(NSString *)saveImageDocuments:(UIImage *)image{
    //拿到图片
    UIImage *imagesave = image;
    NSString *path_sandox = NSHomeDirectory();
    //获取当前时间
    NSString * time= [self getTimeStamp];
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",time]];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];
    return imagePath;
}
+(NSString *)decodeWorkUrl:(NSString *)workUrl
{
    if (workUrl.length > 0) {
        NSString *strResult = [self decryptUseDES:workUrl key:DESKEY];
        if (strResult.length > 0) {
            return strResult;
        }
    }
    return workUrl;
}
+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key {
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil)
    {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+(NSString *)convertToJsonData:(NSDictionary *)dict
{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
+ (NSString *)chatNavDisplayTitleStringWithInterval:(NSTimeInterval)timeInterval
{
    return [self _chatTimeStringWithInterval:timeInterval justNowString:@"在线"];
}
+ (NSString *)chatMessageListTimeStringWithInterval:(NSTimeInterval)timeInterval
{
    return [self _chatTimeStringWithInterval:timeInterval justNowString:@"刚刚"];
}
#pragma mark - Private
+ (NSString *)_chatTimeStringWithInterval:(NSTimeInterval)timeInterval justNowString:(NSString *)justNowString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval time = [nowDate timeIntervalSinceDate:date];
    NSString * strTime;
    if (time <= 60) {  //// 1分钟以内的
        strTime = justNowString;
    }else if(time <= 60*60){  ////  一个小时以内的
        NSInteger mins = time/60;
        strTime = [NSString stringWithFormat:@"%ld分钟前",(long)mins];
        
    }else if(time <= 60*60*24){ //一天之内
        
        NSInteger mins = time/(60*60);
        strTime = [NSString stringWithFormat:@"%ld小时前",(long)mins];
    }else if(time <= 60*60*24*7){ //一周之内
        
        NSInteger mins = time/(60*60*24);
        strTime = [NSString stringWithFormat:@"%ld天前",(long)mins];
    }else if(time <= 60*60*24*30){ //一月之内
        
        NSInteger mins = time/(60*60*24*7);
        strTime = [NSString stringWithFormat:@"%ld周前",(long)mins];
    }else if(time <= 60*60*24*365){ //一年之内
        
        NSInteger mins = time/(60*60*24*30);
        strTime = [NSString stringWithFormat:@"%ld月前",(long)mins];
    }else{
        strTime = @"1年前";
    }
    return strTime;
}
+(NSMutableArray*)getRandomArrFrome:(NSArray*)arr
{
    NSMutableArray *newArr = [NSMutableArray new];
    while (newArr.count != arr.count) {
        //生成随机数
        int x =arc4random() % arr.count;
        id obj = arr[x];
        if (![newArr containsObject:obj]) {
            [newArr addObject:obj];
        }
    }
    return newArr;
}

+ (NSTimeInterval)secondsOfSystemTimeSince:(NSTimeInterval)targetTime
{
    uint64_t serverTime = [ServerTimeMgr getServerStamp];
    NSTimeInterval timeSpace = targetTime - serverTime / 1000;
    return timeSpace;
}

@end
