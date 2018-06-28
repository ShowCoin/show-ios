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



@end
