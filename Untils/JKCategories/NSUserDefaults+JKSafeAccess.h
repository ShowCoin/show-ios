//
//  NSUserDefaults+SafeAccess.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (JKSafeAccess)

// 根据defaultName 得到string
+ (NSString *)jk_stringForKey:(NSString *)defaultName;
// 根据defaultName 得到array
+ (NSArray *)jk_arrayForKey:(NSString *)defaultName;
// 根据defaultName 得到dic
+ (NSDictionary *)jk_dictionaryForKey:(NSString *)defaultName;
// 根据defaultName 得到data
+ (NSData *)jk_dataForKey:(NSString *)defaultName;
// 根据defaultName 得到stringArray
+ (NSArray *)jk_stringArrayForKey:(NSString *)defaultName;

+ (NSInteger)jk_integerForKey:(NSString *)defaultName;

+ (float)jk_floatForKey:(NSString *)defaultName;

+ (double)jk_doubleForKey:(NSString *)defaultName;

+ (BOOL)jk_boolForKey:(NSString *)defaultName;

+ (NSURL *)jk_URLForKey:(NSString *)defaultName;

#pragma mark - WRITE FOR STANDARD

+ (void)jk_setObject:(id)value forKey:(NSString *)defaultName;

#pragma mark - READ ARCHIVE FOR STANDARD

+ (id)jk_arcObjectForKey:(NSString *)defaultName;

#pragma mark - WRITE ARCHIVE FOR STANDARD

+ (void)jk_setArcObject:(id)value forKey:(NSString *)defaultName;
@end
