//
//  SecurityStoreUtils.h
//  ShowLive
//
//  Created by Tim on 2017/7/27.
//  Copyright © 2017年 show. All rights reserved.
//  some code from http://www.jianshu.com/p/9188235eedab
#import <Foundation/Foundation.h>
#import <Security/Security.h>
  

@interface SecurityStoreUtils : NSObject

+ (void)rhKeyChainSave:(id)data withServiceKey:(NSString*)serviceKey;

+ (id)rhKeyChainLoad:(NSString*)serviceKey;

+ (void)rhKeyChainDelete:(NSString *)serviceKey;
/*
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
 */
@end 
