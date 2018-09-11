//
//  SLInviteCacheModel.m
//  ShowLive
//
//  Created by chenyh on 2018/9/7.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLInviteCacheModel.h"

static NSString * const kSLInviteCacheModelKey = @"kSLInviteCacheModelKey";

@interface SLInviteCacheModel ()

@end

@implementation SLInviteCacheModel

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (NSArray *)ignoreArrary{
    return @[@"existAction"];
}

+ (instancetype)currentCache {
    NSData *data = [NSUserDefaults.standardUserDefaults objectForKey:kSLInviteCacheModelKey];
    SLInviteCacheModel *per = nil;
    if (data) {
        per = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } else {
        per = [[self alloc] init];
        [per resetModel];
    }
    return per;
}

- (void)resetModel {
    self.code     = @"";
    self.ratio    = @"0";
    self.nickname = @"";
    self.exit     = NO;
}

- (void)sl_update {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [NSUserDefaults.standardUserDefaults setObject:data forKey:kSLInviteCacheModelKey];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)sl_checkInviteCode:(NSString *)code handler:(SLSimpleBlock)handler {
    [self resetModel];
    if (!IsValidString(code)) {
        if (handler) handler();
        return;
    }
    self.code = code;
    
}


@end
