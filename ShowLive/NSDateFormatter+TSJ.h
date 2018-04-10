//
//  NSDateFormatter+TSJ.h
//  living
//
//  Created by milo on 15/6/18.
//  Copyright (c) 2015年 MJHF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (TSJ)
+ (id)dateFormatter;
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/
@end
