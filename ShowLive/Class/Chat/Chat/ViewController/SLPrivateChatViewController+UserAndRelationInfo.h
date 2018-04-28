//
//  SLPrivateChatViewController+UserAndRelationInfo.h
//  ShowLive
//
//  Created by Mac on 2018/4/14.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLPrivateChatViewController.h"
#import "SLChatRelationInfo.h"

@interface SLPrivateChatViewController()
@property (assign, nonatomic) BOOL isRelationInfoLoading;
@property (assign, nonatomic) BOOL isUserInfoLoading;
@end

@interface SLPrivateChatViewController (UserAndRelationInfo)
@property (nonatomic, strong) SLChatRelationInfo *relationInfo;
- (void)updateUserInfo;
- (void)updateRelationInfo;
- (BOOL)isVip;

@end
