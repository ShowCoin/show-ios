//
//  NSObject+Safe.m
//  ShowLive
//
//  Created by iori_chou on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "NSObject+Safe.h"

@implementation NSObject (Safe)

//安全的字典样式
- (instancetype)safeDictionary {
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return self;
}

@end
