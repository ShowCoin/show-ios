
//
//  NSString+Validation.m
//  CreditGroup
//
//  Created by ang on 14-4-2.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)



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


/*判断是否为空字符串*/
- (BOOL)isEmpty {
    NSString *stricterFilterString = @"^\[ \t]*$";
    NSPredicate *emptyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [emptyTest evaluateWithObject:self];
    
}

/*去除电话号码中的特殊字符*/
- (NSString*)extractNumber{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@" @／：；（）¥「」、[]{}#%-*+=_\\|~＜＞$€^•’@#$%^&*()_+’\\”"];
    NSString *trimmedString = [[[self componentsSeparatedByCharactersInSet:doNotWant]componentsJoinedByString: @""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    return trimmedString;
}

/*隐藏身份证中间的几个数字*/
- (NSString *)ittemDisposeIdcardNumber:(NSString *)idcardNumber;
{
    //星号字符串
    NSString *xinghaoStr = @"";
    //动态计算星号的个数
    for (int i  = 0; i < idcardNumber.length - 7; i++) {
        xinghaoStr = [xinghaoStr stringByAppendingString:@"*"];
    }
    //身份证号取前3后四中间以星号拼接
    idcardNumber = [NSString stringWithFormat:@"%@%@%@",[idcardNumber substringToIndex:3],xinghaoStr,[idcardNumber substringFromIndex:idcardNumber.length-4]];
    //返回处理好的身份证号
    return idcardNumber;
}

+(NSString *)countNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}
- (NSInteger)getStringLenthOfBytes
{
    NSInteger length = 0;
    for (int i = 0; i<[self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChineseChar:s]) {
            
            NSLog(@" s 打印信息:%@",s);
            
            length +=2;
        }else{
            length +=1;
        }
        
        NSLog(@" 打印信息:%@  %ld",s,(long)length);
    }
    return length;
}
- (NSString *)subBytesOfstringToIndex:(NSInteger)index
{
    NSInteger length = 0;
    
    NSInteger chineseNum = 0;
    NSInteger zifuNum = 0;
    
    for (int i = 0; i<[self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChineseChar:s])
        {
            if (length + 2 > index)
            {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            
            length +=2;
            
            chineseNum +=1;
        }
        else
        {
            if (length +1 >index)
            {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            length+=1;
            
            zifuNum +=1;
        }
    }
    return [self substringToIndex:index];
}
//检测中文或者中文符号
- (BOOL)validateChineseChar:(NSString *)string
{
    NSString *nameRegEx = @"[\\u0391-\\uFFE5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}
//检测中文
- (BOOL)validateChinese:(NSString*)string
{
    NSString *nameRegEx = @"[\u4e00-\u9fa5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}
//检测url
- (BOOL)isUrlString {
    NSString *emailRegex = @"[a-zA-z]+://.*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
- (BOOL)isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}
+ (BOOL)isValidString:(NSString *)value
{
    return (    ( value ) &&
            ( [value isKindOfClass:[NSString class]] ) &&
            ( ![@"" isEqualToString:value] ) &&
            ( value.length > 0 ) &&
            ( ![value isKindOfClass:[NSNull class]] ) &&
            ( ![@"(null)" isEqualToString:value] ) &&
            ( ![@"(null)\n" isEqualToString:value] ) &&
            ( [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0 )
            );
}

@end
