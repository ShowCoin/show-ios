//
//  NSString+Trim.h
//  show gx
//
//  Created by show on 2017/10/10.
//  Copyright © 2017年 Beijing Dreamer. All rights reserved.
//

#ifndef NSString_Trim_h
#define NSString_Trim_h

#import <Foundation/Foundation.h>

@interface NSString (Trim)
+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet;
+ (NSString *)trimWhitespace:(NSString *)val;
+ (NSString *)trimNewline:(NSString *)val;


@end

#endif /* NSString_Trim_h */
