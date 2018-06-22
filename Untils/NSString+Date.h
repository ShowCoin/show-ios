//
//  NSString+Date.h
//  show
//
//  Created by showgx  on 16/6/26.
//  Copyright © 2016年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)


+(NSString *)dateWithIntervale:(long long)interval formateStyle:(NSString*)style;
-(long long)dateStringWithFormateStyle:(NSString*)style;


@end
