//
//  NSObject+Safe.m
//  ShowLive
//
//  Created by iori_chou on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "NSObject+Safe.h"

@implementation NSObject (Safe)


- (instancetype)safeDictionary {
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return self;
}

- (instancetype)safeArray {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return self;
}

- (instancetype)safeString {
    if (![self isKindOfClass:[NSString class]]) {
        return nil;
    }
    return self;
}

- (instancetype)safeNumber {
    if (![self isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    return self;
}

@end
