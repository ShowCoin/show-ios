//
//  NSString+Validation.m
//  show gx
//
//  Created by Show on 14-4-2.
//  Copyright (c) 2014年 show. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)
/*判断输入的是否是昵称*/
-(BOOL)isValidNickName;
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [passWordPredicate evaluateWithObject:self];
    
}

/*判断输入的是否是手机号码*/
-(BOOL)isValidPhone

@end
