//
//  KMPathUtils.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "KMPathUtils.h"
#import "KMencryption.h"

@implementation KMPathUtils

static  NSString *__fileUtils_dirPath;

+ (NSString *)generateFileKey {
    NSString *now = [NSString stringWithFormat:@"%010ld",(long)[[NSDate date] timeIntervalSince1970]];
    NSString *ran = [NSString stringWithFormat:@"%010ld",(long)arc4random()];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@",now,ran];
    return fileName;
}

#pragma mark - 视频本地临时存储路径
+ (NSString *)videoLocalTmepPath:(NSString *)fileKey{
    NSString *tempDir = [self getVideoTempDirectoryPath];
    if ([fileKey hasSuffix:@".mp4"]) {
        return [NSString stringWithFormat:@"%@/%@",tempDir,fileKey];
    }else{
        return [NSString stringWithFormat:@"%@/%@.mp4",tempDir,fileKey];
    }
    
}

#pragma mark - 视频缩略图本地临时存储路径  录制时 获取临时路径 上传成功后 替换路径
+(NSString *)videoThumbLocalTmepPath:(NSString *)fileKey{
    NSString *tempDir = [self getVideoTempDirectoryPath];
    return [NSString stringWithFormat:@"%@/%@.jpeg",tempDir,fileKey];
}

+(BOOL)moveVideo:(NSString *)filePath toFileName:(NSString *)fileName{
    if(fileName.length == 0) return NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    fileName = [fileName lastPathComponent];
    if ([fileManager fileExistsAtPath:filePath]) {  //  文件存在
        NSString *path = [self videoFilePath:fileName];
        NSError *error = nil;
        [fileManager moveItemAtPath:filePath toPath:path error:&error];
        return error? NO : YES;
    }
    return NO;
}

+(BOOL)moveImage:(NSString *)filePath toFileName:(NSString *)fileName{
    if(fileName.length == 0) return NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {  //  文件存在
        NSString *path = [self imageFilePath:fileName];
        NSError *error = nil;
        [fileManager moveItemAtPath:filePath toPath:path error:&error];
        return error? NO : YES;
    }
    return NO;
}


+(BOOL)saveImage:(UIImage *)image toFileName:(NSString *)fileName{
    if (image) {
        NSString *path = [self imageFilePath:fileName];
        return [UIImageJPEGRepresentation(image,1) writeToFile:path atomically:YES];
    }
    return NO;
}

+(NSString *)imageFilePath:(NSString *)fileName{
    NSString *dirPath = [self getFileDirectoryPath];
    NSString * path = @"";
    if ([fileName hasSuffix:@".jpeg"]) {
        NSString *temp = [fileName stringByDeletingPathExtension];
        dirPath = [NSString stringWithFormat:@"%@/%@",dirPath,temp];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        path = [NSString stringWithFormat:@"%@/%@",dirPath,fileName];
    }else{
        dirPath = [NSString stringWithFormat:@"%@/%@",dirPath,fileName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        path = [NSString stringWithFormat:@"%@/%@",dirPath,[NSString stringWithFormat:@"%@.jpeg",fileName]];
    }
    return path;
}

+ (NSString *)getVideoTempDirectoryPath{
//    if (!__fileUtils_dirPath || __fileUtils_dirPath.length == 0) {
        __fileUtils_dirPath = QCDocumentDirectory;
//    }
    NSString *dirPath = [__fileUtils_dirPath stringByAppendingPathComponent:@"temp"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

#pragma mark - 获取视频本地地址
+(NSString *)videoFilePath:(NSString *)fileName{
    NSString *dirPath = [self getFileDirectoryPath];
    NSString * path = @"";
    if ([fileName hasSuffix:@".mp4"]) {
        NSString *temp = [fileName stringByDeletingPathExtension];
        dirPath = [NSString stringWithFormat:@"%@/%@",dirPath,temp];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        path = [NSString stringWithFormat:@"%@/%@",dirPath,fileName];
    }else{
        dirPath = [NSString stringWithFormat:@"%@/%@",dirPath,fileName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        path = [NSString stringWithFormat:@"%@/%@",dirPath,[NSString stringWithFormat:@"%@.mp4",fileName]];
    }
    return path;
}

#pragma mark - 获取文件存储文件夹地址
+ (NSString *)getFileDirectoryPath{
//    if (!__fileUtils_dirPath || __fileUtils_dirPath.length == 0) {
        __fileUtils_dirPath = QCLibraryCacheDirectory;
//    }
    NSString *dirPath = [__fileUtils_dirPath stringByAppendingPathComponent:@"video"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}


#pragma mark - 存储资源配置
+ (BOOL)saveSourceConfig:(NSDictionary *)config{
//    if (!__fileUtils_dirPath || __fileUtils_dirPath.length == 0) {
        __fileUtils_dirPath = QCLibraryCacheDirectory;
//    }
    NSString *dirPath = [__fileUtils_dirPath stringByAppendingPathComponent:@"source"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *path = [dirPath stringByAppendingPathComponent:@"config.js"];
    return [config writeToFile:path atomically:YES];
}

#pragma mark - 获取资源配置
+ (NSDictionary *)getSourceConfig{
//    if (!__fileUtils_dirPath || __fileUtils_dirPath.length == 0) {
        __fileUtils_dirPath = QCLibraryCacheDirectory;
//    }
    NSString *dirPath = [__fileUtils_dirPath stringByAppendingPathComponent:@"source"];
    NSString *path = [dirPath stringByAppendingPathComponent:@"config.js"];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}


+ (NSString *)getSourceRootDirPath{
//    if (!__fileUtils_dirPath || __fileUtils_dirPath.length == 0) {
        __fileUtils_dirPath = QCLibraryCacheDirectory;
//    }
    NSString *dirPath = [__fileUtils_dirPath stringByAppendingPathComponent:@"source"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

#pragma mark - 根据文件名获取文件夹
+ (NSString *)getSourceDirPath:(NSString *)name{
    NSString *rootDir = [self getSourceRootDirPath];
    NSString *dirPath = [rootDir stringByAppendingPathComponent:name];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

#pragma mark - 临时存储图片
+(NSString *)tempSaveImage:(UIImage *)image{
    NSString *dirPath = [self getTempFileDirectoryPath];
    NSString *fileID = [self generateFileKey];
    NSString *path = [dirPath stringByAppendingPathComponent:fileID];
    
    BOOL bo = [UIImageJPEGRepresentation(image,1) writeToFile:path atomically:YES];
    return bo ? path :@"";
}

+ (NSString *)getTempFileKeyWithPath:(NSString *)path {
    NSRange range = [path rangeOfString:@"/temp/"];
    if (range.location == NSNotFound) {
        return path;
    }
    return [path substringFromIndex:range.length+range.location];
}

+ (NSString *)getTureFilePathInTempFolderWithFilePath:(NSString *)filePath
{
    if (!filePath) {
        return nil;
    }
    NSString *dirPath = [KMPathUtils getTempFileDirectoryPath];
    NSString *pathKey = [KMPathUtils getTempFileKeyWithPath:filePath];
    NSString *turePath = [dirPath stringByAppendingPathComponent:pathKey];
    return turePath;
}

#pragma mark - 获取临时文件存储文件夹地址
+ (NSString *)getTempFileDirectoryPath{
//    if (!__fileUtils_dirPath || __fileUtils_dirPath.length == 0) {
        __fileUtils_dirPath = QCDocumentDirectory;
//    }
    NSString *dirPath = [__fileUtils_dirPath stringByAppendingPathComponent:@"temp"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

+(void)removeTempFile:(NSString *)Path{
    if (Path.length >0) {
        [[NSFileManager defaultManager] removeItemAtPath:Path error:nil];
    }
}

+(NSString *)getEditDirWithPath:(NSString *)path{
    if ([path hasSuffix:@".mp4"]) {
       path = [path stringByDeletingPathExtension];
    }
    
    NSString *dirPath = [path stringByAppendingPathComponent:@"Edit"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

+(void)writeErrorFile:(NSDictionary *)dict parameters:(NSDictionary *)parameters{
//    if (!__fileUtils_dirPath || __fileUtils_dirPath.length == 0) {
        __fileUtils_dirPath = QCLibraryCacheDirectory;
//    }
    NSString *dirPath = [__fileUtils_dirPath stringByAppendingPathComponent:@"error"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *name = [NSString stringWithFormat:@"error :%f",[[NSDate date] timeIntervalSince1970]];
    NSString *path = [dirPath stringByAppendingPathComponent:name];
    dict = [KMencryption cryptDict:dict parameters:parameters];
    [dict writeToFile:path atomically:YES];
}

+(NSString *)getTempMagicDirectoryPath{
    __fileUtils_dirPath = QCLibraryCacheDirectory;
    NSString *dirPath = [__fileUtils_dirPath stringByAppendingPathComponent:@"magic"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}
+(void)removeTempMagicDirectoryPath{
    __fileUtils_dirPath = QCLibraryCacheDirectory;
    NSString *dirPath = [__fileUtils_dirPath stringByAppendingPathComponent:@"magic"];
    [[NSFileManager defaultManager] removeItemAtPath:dirPath error:nil];
}

@end
