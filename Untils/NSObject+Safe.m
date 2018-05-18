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
//安全的数组样式
- (instancetype)safeArray {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return self;
}
//安全的字符串样式
- (instancetype)safeString {
    if (![self isKindOfClass:[NSString class]]) {
        return nil;
    }
    return self;
}
//安全的Number样式
- (instancetype)safeNumber {
    if (![self isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    return self;
}

@end
