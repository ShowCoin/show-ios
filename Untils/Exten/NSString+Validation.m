
//
//  NSString+Validation.m
//  CreditGroup
//
//  Created by ang on 14-4-2.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)
/*判断输入的是否是昵称*/
-(BOOL)isValidNickName;
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [passWordPredicate evaluateWithObject:self];

}
/*判断输入的是否是手机号码*/
-(BOOL)isValidPhone
{
    NSString *stricterFilterString = @"\\b(1)[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [emailTest evaluateWithObject:self];
}

/*判断输入帐号是否为邮箱*/
-(BOOL)isValidEmail
{
    
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]";
    NSString *emailRegex = stricterFilterString ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
/*帐号密码格式*/
-(BOOL)isValidPassword
{
    NSString *stricterFilterString = @"^[A-Za-z0-9!@#$%^&*.~/{}|()'\"?><,.`+-=_:;\\\\[]]\\\[]{6,16}$";
    //    NSLog(@"stricterFilterString = %@",stricterFilterString);
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:self];
}
/*判断是否有效的整数*/
-(BOOL)isValidInteger {
    NSString *stricterFilterString = @"^\\d+$";
    NSPredicate *integerTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [integerTest evaluateWithObject:self];
}

/*判断是否有效的正整数*/
-(BOOL)isValidPositiveInteger {
    NSString *stricterFilterString = @"^[0-9]*[1-9][0-9]*$";
    NSPredicate *integerTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [integerTest evaluateWithObject:self];
}
/*判断是否有效的浮点数*/
- (BOOL)isValidFloat {
    NSString *stricterFilterString = @"^(\\d*\\.)?\\d+$";
    NSPredicate *floatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [floatTest evaluateWithObject:self];
}

/*判断是否有效的正浮点数*/
- (BOOL)isValidPositiveFloat {
    NSString *stricterFilterString = @"^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$";
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [test evaluateWithObject:self];
}



@end
