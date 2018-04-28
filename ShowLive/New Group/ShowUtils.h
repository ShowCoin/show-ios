//
//  KMUtils.h
//  NetDemo
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowUtils : NSObject

/**
 *  手机号处理
 */
+ (NSString*)formatePhoneNumber:(NSString*)phoneNumber;

/**
 *  Idfa号，常用语广告推广
 */
+(NSString *)idfa;
/**
 *  Idfv号，区别于m2中的idfv，这个不用取keychain里的数据
 */
+(NSString *)idfv;
/**
 *  机型
 */
+(NSString *)phoneType;
/**
 *  终端运营商名称（5位数字，前端转换，若转换不了则上传数字）
 */
+(NSString *)op;
/**
 *  操作系统名称
 */
+(NSString *)os;
/**
 *  屏幕分辨率
 */
+(NSString *)sc;
/**
 *  终端所处国家
 */
+(NSString *)co;
/**
 *  操作系统版本
 */
+(NSString *)deviceVersion;
/**
 *  应用版本号，A：数字类型 I：字符串类型
 */
+(NSString *)appVersion;
/**
 *  应用版本名，字符串型，自定义的
 */
+(NSString *)vn;
/**
 *  联网方式
 */
+(NSString *)netType;
/**
 *  请求创建时间
 */
+(NSString *)time;
/**
 *  M2 A：md5(imei+androidId+SerialNo) I：idfv，keychain存储，保证idfv不变
 */
+(NSString *)device_uuid;
/**
 *  设备名称
 */
+(NSString *)deviceName;
/**
 *  渠道号，A区别不同渠道包；I无法分包，需要另行计算 android
 */
+(NSString *)channel;
/**
 *  MAC地址，仅对WIFI连接时有效。  android
 */
+(NSString *)mac;
/**
 * IMEI串号   android
 */
+(NSString *)im;
/**
 * 手机型号
 */
+(NSString *)deviceModel;
/**
 *  是否支持ARKit
 */
+(BOOL)isSupportARKit;

@end
