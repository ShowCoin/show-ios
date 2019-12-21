
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
        if ([self.type isEqualToString:@"phone"]) {
            self.codeType = DCCodeTypeSMS;
            _text = @"短信验证";
        }
        if ([self.type isEqualToString:@"email"]) {
            self.codeType = DCCodeTypeEmail;
            _text = @"邮箱验证";
        }
        if ([self.type isEqualToString:@"googleCode"]) {
            self.codeType = DCCodeTypeGoogle;
            _text = @"谷歌验证";
        }
    }
    return _text;
}

@end
