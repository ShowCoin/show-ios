//
//  SLPrivateChatViewController+Common.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController+Common.h"
#import "ShowWaringView.h"

@implementation SLPrivateChatViewController (Common)
#pragma mark - Toast

- (void)addNetStatusObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkDidChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)netWorkDidChanged:(NSNotification *)notification
{
    NSNumber *statusNumber = [notification userInfo][AFNetworkingReachabilityNotificationStatusItem];
    if (statusNumber) {
        switch (statusNumber.integerValue) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:{
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                break;
            }
            default:
                break;
        }
    }
}

@end
