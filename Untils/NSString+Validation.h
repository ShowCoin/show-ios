//
//  NSString+Validation.h
//  CreditGroup
//
//  Created by showgx on 18-4-2.
//  Copyright (c) 2018年 SHOW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)


/*判断输入的是否是昵称*/
-(BOOL)isValidNickName;

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

- (BOOL)isChinese;//判断是否是纯汉字

- (BOOL)includeChinese;//判断是否含有汉字


@end
