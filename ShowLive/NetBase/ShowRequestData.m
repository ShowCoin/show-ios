//
//  ShowRequestData.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowRequestData.h"

@implementation ShowRequestData
@synthesize querys = _querys;
@synthesize parameters = _parameters;

- (NSDictionary *)querys {
    if (!_querys) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        _querys = dic;
    }
    return _querys;
}

- (NSMutableDictionary *)parameters {
    if (!_parameters) {
        _parameters = [NSMutableDictionary dictionary];
    }
    return _parameters;
}

- (void)appendPostDictionary:(NSDictionary *)dic {
    for (id key in dic) {
        id value = [dic valueForKey:key];
        [self appendPostValue:value key:key];
    }
}

- (void)appendPostValue:(id)value key:(NSString *)key {
    [self.parameters setValue:value forKey:key];
}

@end
