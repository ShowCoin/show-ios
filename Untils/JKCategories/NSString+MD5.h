//
//  NSString+MD5.h
//  CreditGroup
//
//  Created by JPlay on 14-2-21.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

+(NSString *)MD5WithString:(NSString *)string;
+(NSString *)MD5AndSaltString:(NSString *)string;

@end
