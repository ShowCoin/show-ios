//
//  NSDictionary+JKSafeAccess.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 15/1/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (JKSafeAccess)

//判断是否有key
- (BOOL)jk_hasKey:(NSString *)key;
//key对应的字符串
- (NSString*)jk_stringForKey:(id)key;
//key对应的number
- (NSNumber*)jk_numberForKey:(id)key;
//key对应的decimalNumber
- (NSDecimalNumber *)jk_decimalNumberForKey:(id)key;
//key对应的array
- (NSArray*)jk_arrayForKey:(id)key;
//key array对应的字典
- (NSDictionary*)jk_dictionaryForKey:(id)key;
//key key对应的interge
- (NSInteger)jk_integerForKey:(id)key;
//key key对应的unsignedInteger
- (NSUInteger)jk_unsignedIntegerForKey:(id)key;
//key key对应的bool
- (BOOL)jk_boolForKey:(id)key;

- (int16_t)jk_int16ForKey:(id)key;

- (int32_t)jk_int32ForKey:(id)key;

- (int64_t)jk_int64ForKey:(id)key;

- (char)jk_charForKey:(id)key;

- (short)jk_shortForKey:(id)key;

- (float)jk_floatForKey:(id)key;

- (double)jk_doubleForKey:(id)key;

- (long long)jk_longLongForKey:(id)key;

- (unsigned long long)jk_unsignedLongLongForKey:(id)key;

- (NSDate *)jk_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)jk_CGFloatForKey:(id)key;

- (CGPoint)jk_pointForKey:(id)key;

- (CGSize)jk_sizeForKey:(id)key;

- (CGRect)jk_rectForKey:(id)key;
@end

#pragma --mark NSMutableDictionary setter

@interface NSMutableDictionary(SafeAccess)

-(void)jk_setObj:(id)i forKey:(NSString*)key;

-(void)jk_setString:(NSString*)i forKey:(NSString*)key;

-(void)jk_setBool:(BOOL)i forKey:(NSString*)key;

-(void)jk_setInt:(int)i forKey:(NSString*)key;

-(void)jk_setInteger:(NSInteger)i forKey:(NSString*)key;

-(void)jk_setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;

-(void)jk_setCGFloat:(CGFloat)f forKey:(NSString*)key;

-(void)jk_setChar:(char)c forKey:(NSString*)key;

-(void)jk_setFloat:(float)i forKey:(NSString*)key;

-(void)jk_setDouble:(double)i forKey:(NSString*)key;

-(void)jk_setLongLong:(long long)i forKey:(NSString*)key;

-(void)jk_setPoint:(CGPoint)o forKey:(NSString*)key;

-(void)jk_setSize:(CGSize)o forKey:(NSString*)key;

-(void)jk_setRect:(CGRect)o forKey:(NSString*)key;

@end
