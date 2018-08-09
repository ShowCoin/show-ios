//
//  NSObject+NSInteger.m
//  Show
//
//  Created by show  gx on 16/8/25.
//  Copyright © Show. All rights reserved.
//

#import "NSObject+NSInteger.h"

@implementation NSObject (NSInteger)


+(NSString *)getStringForNum:(NSInteger)num
{
    
    NSInteger count =num;
    if (count < 0) {
        count = 0;
    }
    NSString * str;
    if (count >= 1000) {
  
@end
