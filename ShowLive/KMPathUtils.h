//
//  KMPathUtils.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KMPathUtils : NSObject
/**
 *  自动生成 fileKey
 */
+ (NSString *)generateFileKey;

#pragma mark - 临时路径
/**
 *  视频本地临时存储路径  录制时 获取临时路径 上传成功后 替换路径
 */
+ (NSString *)videoLocalTmepPath:(NSString *)fileKey;

/**
 *  视频缩略图本地临时存储路径  录制时 获取临时路径 上传成功后 替换路径
 */
+ (NSString *)videoThumbLocalTmepPath:(NSString *)fileKey;

#pragma mark - 移动文件
/**
 *  移动视频文件
 */
+ (BOOL)moveVideo:(NSString *)filePath toFileName:(NSString *)fileName;

#pragma mark - 保存视频缩略图
/**
 *  存储图片
 */
+ (BOOL)saveImage:(UIImage *)image toFileName:(NSString *)fileName;

#pragma mark - 获取地址
/**
 *  获取视频本地地址
 */
+(NSString *)videoFilePath:(NSString *)fileName;

/**
 *  获取图片本地地址
 */
+(NSString *)imageFilePath:(NSString *)fileName;

/**
 *  获取文件存储文件夹地址
 */
+(NSString *)getFileDirectoryPath;

#pragma mark - 资源配置
/**
 *  存储资源配置
 */
+ (BOOL)saveSourceConfig:(NSDictionary *)config;

/**
 *  获取资源配置
 */
+ (NSDictionary *)getSourceConfig;

/**
 *  获取资源根文件夹
 */
+ (NSString *)getSourceRootDirPath;

/**
 *  根据文件名获取文件夹
 */
+ (NSString *)getSourceDirPath:(NSString *)name;

#pragma mark - 临时存储图片
/**
 *  存储图片
 */
+ (NSString *)tempSaveImage:(UIImage *)image;
/**
 *  移除临时资源
 */
+(void)removeTempFile:(NSString *)Path;

#pragma mark - 获取视频编辑文件夹
+(NSString *)getEditDirWithPath:(NSString *)path;

/**
 *  写入报错文件
 */
+(void)writeErrorFile:(NSDictionary *)dict parameters:(NSDictionary *)parameters;

/**
 *  获取保存文件的路径
 */
+ (NSString *)getTempFileDirectoryPath;
/**
 *  截取保存文件的key
 */
+ (NSString *)getTempFileKeyWithPath:(NSString *)path;

/// 根据当前沙盒路径组装，path可以是完整路径或者文件名
+ (NSString *)getTureFilePathInTempFolderWithFilePath:(NSString *)filePath;

#pragma mark - 特效抽帧路径
+(NSString *)getTempMagicDirectoryPath;
+(void)removeTempMagicDirectoryPath;
+ (NSString *)getVideoTempDirectoryPath;
@end
