//
//  ShowResourcesService.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/5.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowResourcesService.h"

#define STORE_VERSION_KEY @"STORE_VERSION_KEY"
@implementation ShowResourcesService


+(ShowResourcesService *)shared{
    static ShowResourcesService *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)updateResoucesWithDic:(NSDictionary *)newDic{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Localizable" ofType:@"strings"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    [dic addEntriesFromDictionary:newDic];
    [dic writeToFile:filePath atomically:YES];
}

#pragma mark -和后台联调的时候继续修改
+ (NSString *)readLastAppVerison {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *appverison = [userDefaults objectForKey:STORE_VERSION_KEY];
    return appverison;
}

+ (void)saveCurrentAppVerison {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[self appVersion] forKey:STORE_VERSION_KEY];
    [userDefaults synchronize];
}

+ (NSString *)appVersion{
    NSString *_appVersion;
    if (NSClassFromString(@"XCTest")) {
        NSDictionary *infoDictionary =  [[NSBundle bundleForClass:[self class]] infoDictionary];
        _appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }else{
        NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
        _appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
    _appVersion = (_appVersion&&_appVersion.length > 0)?_appVersion:@"unknown";
    return _appVersion;
}

- (NSString *)stringForKey:(NSString *)key{
    if(!key){
        return @"";
    }
    return  NSLocalizedString(key,nil);
}

- (UIImage *)imageForkey:(NSString *)name{
    //后期做国际化的时候替换
    return [UIImage imageNamed:name];
}

@end
