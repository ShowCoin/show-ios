//
//  HLLeadProfile.m
//  QinChat
//
//  Created by liyingbin on 16/10/6.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "HLLeadProfile.h"



@implementation HLLeadProfile
/**
 * 单例
 */
+ (instancetype)leadProfile {
    static HLLeadProfile *__leadProfile = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __leadProfile = [[HLLeadProfile alloc] init];
    });
    
    return __leadProfile;
}
- (void)setBool:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setNewUsrBool {
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADREPLYVIDEO];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADSENDVIDEO];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADSENDVIDEONO];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADSENDTALKBACK];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADCANCELTALKBACK];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADSLIDEUP];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADSLIDEDOWN];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADSLIDELEFT];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADSHOWEFFECTSHOW];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADFILTERSHOW];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADSELECTSENDVIDEO];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADEFFECTS];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADMOUTHGAME];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADGAMEGSEND];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADGAMEANIMATION];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADMSGDETAIL];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADXIONGMAO];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEAD4G];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADIF];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADDETAILDETAIL];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADMAGICPEN];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LEADMAGICEFFECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)boolForKey:(NSString *)str{
    NSString *boolStr = [[NSUserDefaults standardUserDefaults] objectForKey:str];
    if ([boolStr isEqualToString:@"2"]) {
        return NO;
    }
    return YES;
}
@end
