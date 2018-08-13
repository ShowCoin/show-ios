//
//  NSString+Validation.h
//  CreditGroup
//
//  Created by ang on 14-4-2.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 判断是否有效的string，包括类型、空白字符、(null)等的判断
#define IsValidString(string) ([NSString isValidString:string])

@interface NSString (Validation)


/*判断输入的是否是昵称*/
-(BOOL)isValidNickName;

/*判断输入的是否是钱包地址*/
- (BOOL)isValidETHAddress;

/*判断输入的是否是BTC钱包地址*/
- (BOOL)isValidBTCAddress;

/*判断输入的是否是手机号码*/
-(BOOL)isValidPhone;

/*判断输入帐号是否为邮箱*/
-(BOOL)isValidEmail;

/*判断密码只能是6-16位数字和字母*/
-(BOOL)isValidPassword;

/*判断是否有效的整数*/
-(BOOL)isValidInteger;

/*判断是否有效的整数*/
-(BOOL)isValidPositiveInteger;

/*判断是否有效的浮点数*/
- (BOOL)isValidFloat;

/*判断是否有效的正浮点数*/
- (BOOL)isValidPositiveFloat;

/*判断是否为空字符串*/
- (BOOL)isEmpty;

/*去除电话号码中的特殊字符*/
- (NSString*)extractNumber;

/*隐藏身份证中间的几个数字*/
- (NSString *)ittemDisposeIdcardNumber:(NSString *)idcardNumber;
/*计算文组高度*/
- (CGSize)stringSizeWithFont:(UIFont *)font preComputeSize:(CGSize)preSize;

+(NSString *)countNumAndChangeformat:(NSString *)num;

- (NSInteger)getStringLenthOfBytes;

- (NSString *)subBytesOfstringToIndex:(NSInteger)index;

+ (BOOL)isValidString:(NSString *)value;

@end
