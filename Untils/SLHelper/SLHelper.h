//
//  SLHelper.h
//  ShowLive
//
//  Created by iori_chou on 2018/2/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"

@interface SLHelper : NSObject
#pragma mark 一些常用的公共方法



/**
 *@brief 将对象转化为json字符串
 */
+ (NSString *)jsonStringFromObject:(id)object;

//将json转换成字典
+ (NSDictionary *)dictionaryWithJSON:(id)json;

/**
 *@brief 安全的取字典中的值
 */
+ (id)valueForKey:(NSString *)key object:(NSDictionary *)object;

/**
 @brief 通过正则表达式判断是否是手机号码
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/**
 @brief 通过正则表达式判断是合法昵称
 */
+ (BOOL)isAvailableName:(NSString *)name;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;

/**
 @brief 通过正则表达式判断是否是身份证号码
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
/**
 *@brief 通过URLString获取Scheme的索引
 *@return 如果没找到，则返回-1
 */
+ (NSInteger)getUrlSchemesIndex:(NSString*)URLString;
/**
 @brief 是否是空字符串
 */
+ (BOOL) isBlankString:(NSString *)string;

/**
 @brief 是否为正数
 */
+ (BOOL)isPositiveNumber:(NSString *)numStr;

/**
 @pram postion(key:位置  value:长度)
 */
+(NSMutableAttributedString *)setNSStringCorlor:(NSString *)_content positon:(NSDictionary*)positionDict withColor:(UIColor*)color;

+ (NSMutableAttributedString *)appendString:(NSString *)string withColor:(UIColor *)color font:(UIFont *)font lenght:(int)lenght;
/**
 *@brief 同步日历
 */
+(void)synchronizedToCalendarTitle:(NSString *)title location:(NSString *)location;

/** 获取NSBundele中的资源图片 */
+ (UIImage *)imageAtApplicationDirectoryWithName:(NSString *)fileName;
#pragma mark 文件系统的操作方法
/** 创建文件夹 */
+ (BOOL)createFolder:(NSString*)folderPath isDirectory:(BOOL)isDirectory;

/** 得到用户document中的一个路径 */
+ (NSString*)getPathInUserDocument:(NSString *)fileName;

/** 将文件大小格式化，按照KB\M\G的方式展示*/
+ (NSString *)formatFileSize:(long long)fileSize;

/** 文件创建日期 */
+ (NSDate *)dateOfFileCreateWithFolderName:(NSString *)folderName cacheName:(NSString *)cacheName;

/** 统计某个文件的磁盘空间大小 */
+ (int)sizeOfFile:(NSString *)path;


@end
