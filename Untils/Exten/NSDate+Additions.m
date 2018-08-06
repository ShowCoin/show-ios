//
//  NSDate+Additions.m
//  It'sMyCoupon
//
//  Created by Shingo Yabuki on 12-6-4.
//  Copyright (c) 2012年 c2y. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

- (NSDate *)addDays:(NSInteger)days {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:0xff fromDate:self];
    [comps setDay:([comps day]+ days)];
    return [calendar dateFromComponents:comps];
}



@end
