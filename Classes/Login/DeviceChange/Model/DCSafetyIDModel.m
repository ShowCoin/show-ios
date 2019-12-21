
//
//  DCSafetyIDModel.m
//  ShowLive
//
//  Created by chenyh on 2019/1/28.
//  Copyright © 2019 vning. All rights reserved.
//

#import "DCSafetyIDModel.h"

@implementation DCSafetyIDModel

+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"codeType", @"text", @"detail"];
}

- (NSString *)text {
    if (!_text) {
        
    }
    return _text;
}

@end
