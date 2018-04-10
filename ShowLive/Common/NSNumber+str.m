//
//  NSNumber+str.m
//  ShowLive
//
//  Created by Tim on 2017/8/7.
//  Copyright © 2017年 show. All rights reserved.
//

#import "NSNumber+str.h"

@implementation NSNumber(str)
- (CGSize)sizeWithAttributes:(nullable NSDictionary<NSString *, id> *)attrs{
    return [[self stringValue] sizeWithAttributes:attrs];
}

@end
