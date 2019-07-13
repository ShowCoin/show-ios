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

/** 统计某个文件夹的磁盘空间大小 */
+ (long long)sizeOfFolder:(NSString*)folderPath;

/** 移除某个文件夹下的所有文件 */
+ (void)removeContentsOfFolder:(NSString *)folderPath;

/** 移除某个文件夹下的所有文件(非变例)并重新创建被删除的文件夹 */
+ (void) deleteContentsOfFolder:(NSString *)folderPath;


#pragma mark 计算字符串尺寸方法
/**
 *@brief 根据字符串获取label的高度
 *@param labelString label的text
 *@param fontSize label的字体大小，以systemFont为标准
 *@param width 最大宽度
 *@param height 最大高度
 */
+ (CGFloat)heightForLabelWithString:(NSString *)labelString withFontSize:(CGFloat)fontSize withWidth:(CGFloat)width withHeight:(CGFloat)height;
/**
 *@brief 根据字符串获取label的宽度
 *@param labelString label的text
 *@param fontSize label的字体大小，以systemFont为标准
 *@param width 最大宽度
 *@param height 最大高度
 */
+ (CGFloat)widthForLabelWithString:(NSString *)labelString withFontSize:(CGFloat)fontsize withWidth:(CGFloat)width withHeight:(CGFloat)height;

/**
 *@brief 根据字符串获取label的尺寸
 *@param labelString label的text
 *@param font label的字体
 *@param size 限制的最大尺寸
 */
+ (CGSize)sizeForLabelWithString:(NSString *)string withFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *@brief 保存图片到相册
 */
+(NSString *)saveImageDocuments:(UIImage *)image;

#pragma mark 时间格式转换
/**
 *@brief 获取当前时间戳，并转化为字符串
 **/
+(NSString *)getTimeStamp;
/**
 *@brief 将时间格式字符串按照format格式转化为需要的时间格式字符串
 */
+ (NSString *)formatDateWithString:(NSString *)dateString format:(NSString *)format;
/**
 *@brief 将date按照format格式转化为字符串
 */
+ (NSString *)formatDateWithDate:(NSDate *)date format:(NSString *)format;
/**
 *@brief 将时间戳按照format格式化为字符串
 *@param timeInterval 1970开始的时间戳
 */
+ (NSString *)formatTimeInterval:(NSTimeInterval)timeInterval format:(NSString *)format;
/**
 *@brief 将时间格式字符串转化为date
 */
+ (NSDate *)dateValueWithString:(NSString *)dateStr ByFormatter:(NSString *)formatter;
/**
 *@brief 给出date，返回这个时间点是星期几
 */
+ (NSString *)weekdayStringValue:(NSDate*)date;

/**
 *@brief 将时间戳转换成时分秒
 */
+(NSString *)getTimeIntervalWithTime:(NSTimeInterval)timeInterval;
/**
 *  时间补0
 *
 *  @param str str description
 *
 *  @return return value description
 */
+ (NSString *)fillZeroWithString:(NSString *)str;

+(NSString *)getTwoCharTimeIntervalWithTime:(NSInteger)timeInterval formatStr:(NSString *)formatStr;

#pragma mark 归档，解归档
+ (NSData *)archiverObject:(NSObject *)object forKey:(NSString *)key;
+ (NSObject *)unarchiverObject:(NSData *)archivedData withKey:(NSString *)key;

#pragma mark 从NSUserDefaults取值或存值
+ (id)valueForKey:(NSString *)key;
+ (void)setValue:(id)value forKey:(NSString *)key;

#pragma mark 字符串格式化或单位换算
/**
 *@brief 对数字字符串进行友好的格式化，每四个空一格
 */
+ (NSString *)friendFormatString:(NSString *)sourceStr;
/**
 *@brief 去掉小数点后面多余的0并且只保留两位小数
 */
+(NSString *)trimright0:(double )param;
/**
 *@brief 换算距离，大于99km，返回>99km
 *@note 单位为m或km
 */
+ (NSString *)transformMetreToKilometre:(NSString *)meter;//>99km
/**
 *@brief 换算距离，大于99千，返回>99千
 *@note 单位为千
 */
+ (NSString *)transformMetreToKilometreAccurate:(NSString *)meter;
/**
 *@brief 计算开始时间与结束时间中间相隔xx天
 *@param startTime 开始时间
 *@param endTime 结束时间
 */
+(NSString *)getLeftTimeWithStartTime:(double)startTime endTime:(double)endTime;
/**
 *@brief 数字统一规范
 *0-9999显示全数字1234
 *>9999，保留一位小数99.9万
 *>100万，不保留小数333万
 */
+ (NSString *)transformNumbers:(NSInteger)number;
/**
 *@brief 金币统一规范
 *显示全数字1,234,123,231
 */
+ (NSString *)transformMoney:(NSString *)string;
#pragma mark 系统和设备信息
/**
 *@brief 获取iOS系统的版本
 */
+ (NSString *)iOSVersion;

/**
 *    @brief 获取当前设备ios版本号
 *  @return 返回值是float型
 */
+(float) getCurrentDeviceVersion;
/**
 *    @brief  获取用户的ADFA
 *
 */
+ (NSString *) getAdvertisingIdentifier;

/**
 *    @brief 获取当前设备类型如ipod，iphone，ipad
 *
 */
+ (NSString *)deviceType;

/**
 *    @brief    获取请求$val 是所有参数值的字符串连接,以键值逆向排序
 *
 *    @param     dict     请求参数
 *
 *    @return     val
 */
+(NSString *)getValPara:(NSMutableDictionary *)dict;

/**
 *    @brief    将json数据转换成id
 *
 *    @param data 数据
 *
 *    @return     id类型的数据
 */
+ (id)parserJsonData:(id)jsonData;

//IOS 异或加密
+(NSString *)obfuscate:(NSString *)string withKey:(NSString *)key;

//日期 去除时分秒
+ (NSString *)DescriptionWithDate:(NSDate *)date;
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath;
//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath;
+ (NSString *) compareCurrentTime:(NSString *)str;
/**
 解密作品url
 
 @param workUrl 待解密的作品url
 @return 解密后的作品url
 */
+(NSString *)decodeWorkUrl:(NSString *)workUrl;

+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;
+(NSString *)convertToJsonData:(NSDictionary *)dict;
**
聊天会话页标题显示

@param timeInterval 时间戳
@return string
*/
+ (NSString *)chatNavDisplayTitleStringWithInterval:(NSTimeInterval)timeInterval;


/**
 聊天-消息列表cell时间显示转换
 
 @param timeInterval 时间戳
 @return string
 */
+ (NSString *)chatMessageListTimeStringWithInterval:(NSTimeInterval)timeInterval;

/// 获取纠正后的系统时间和targetTime时间戳之差
+ (NSTimeInterval)secondsOfSystemTimeSince:(NSTimeInterval)targetTime;
//打乱数组顺序
+(NSMutableArray*)getRandomArrFrome:(NSArray*)arr;
+(NSData *)greatePublic:(NSData *)privateKey;
@end
