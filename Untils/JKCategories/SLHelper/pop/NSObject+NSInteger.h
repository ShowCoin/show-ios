//
//  NSObject+NSInteger.h
//  Show
//
//  Created by show gx on 16/8/25.
//  Copyright © show gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSInteger)

//保留一位小数（进1）
+(NSString *)getStringForNum:(NSInteger)num;
//保留一位小数（去尾）
+(NSString *)getStringTwoDecimalPlaces:(NSInteger)num;

  
@end
