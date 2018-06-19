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



//+ (NSTimeInterval)secondsOfSystemTimeSince:(NSTimeInterval)targetTime
//{
//    uint64_t serverTime = [ServerTimeMgr getServerStamp];
//    NSTimeInterval timeSpace = targetTime - serverTime / 1000;
//    return timeSpace;
//}

@end
