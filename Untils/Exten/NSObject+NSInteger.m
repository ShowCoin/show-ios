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
        NSInteger count1 = count/100;
        if (count%100>0) {
            count1 = count1 + 1;
        }
        str = [NSString stringWithFormat:@"%ld.%ldk",count1/10,count1%10];
        
    }
    else
    {
        str = [NSString stringWithFormat:@"%ld",(long)count];
    }
    
    return str;
    
}

+(NSString *)getStringTwoDecimalPlaces:(NSInteger)num
{
    
    NSInteger count =num;
    if (count < 0) {
        count = 0;
    }
    NSString * str;
    if (count >= 1000) {
        NSInteger count1 = count/100;
        str = [NSString stringWithFormat:@"%ld.%ldk",count1/10,count1%10];
        
    }
    else
    {
        str = [NSString stringWithFormat:@"%ld",count];
    }
    
    return str;
}

+(NSString*)starDiamondFromChinayuan:(NSInteger)num
{
    NSInteger star = num*10;
    NSString * starStr = [NSString stringWithFormat:@"%ld",star];
    return starStr;
}


+(NSString*)starDiamondFromDollar:(NSInteger)num
{
    NSInteger star = num*60;
    NSString * starStr = [NSString stringWithFormat:@"%ld",star];
    return starStr;
    
}
@end
