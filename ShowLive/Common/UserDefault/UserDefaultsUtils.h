               //
//  Constants.h
//  LoanCalculator
//
//  Created by haodai on 14-9-24.
//  Copyright (c) 2014年 haodai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtils : NSObject

+(void)saveValue:(id) value forKey:(NSString *)key;

+(id)valueWithKey:(NSString *)key;
+(NSInteger)integerValueWithKey:(NSString *)key;
+(void)saveIntergerValue:(NSInteger)value withKey:(NSString *)key;
+(BOOL)boolValueWithKey:(NSString *)key;

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

+(void)removeValueforKey:(NSString*)key;

//+(void)print;

@end
