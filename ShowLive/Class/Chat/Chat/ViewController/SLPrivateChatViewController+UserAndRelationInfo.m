//
//  SLPrivateChatViewController+UserAndRelationInfo.m
//  ShowLive
//
//  Created by 周华 on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController+UserAndRelationInfo.h"
#import "SLPrivateChatViewController+Business.h"
#import "SLUserCacheManager.h"
@implementation SLPrivateChatViewController (UserAndRelationInfo)
#pragma mark - Properties
- (void)setRelationInfo:(SLChatRelationInfo *)relationInfo
{
    objc_setAssociatedObject(self, @selector(relationInfo), relationInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SLChatRelationInfo *)relationInfo
{
    id obj = objc_getAssociatedObject(self, @selector(relationInfo));
    if (!obj) {
        obj = [UserCacheMgr getRelationInfo:self.targetUid];
        if (!obj) {
            [self updateUserInfo];
        } else {
            [self setRelationInfo:obj];
        }
    }
    return obj;
}

#pragma mark - Update
- (void)updateUserInfo
{
    if (self.isRelationInfoLoading) {
        return;
    }
    self.isRelationInfoLoading = YES;
    if (!self.business) {
        [self setupBusiness];
    }
    @weakify(self);
    [self.business fetchUserInfo:^(BOOL success, ShowUserModel *user) {
        @strongify(self);
        if (success && user) {
            self.targetUser = user;
            [UserCacheMgr updateUser:user];
            [self.navigationBarView setNavigationTitle:user.nickname];
        }
        self.isRelationInfoLoading = NO;
    }];
}

- (void)updateRelationInfo
{
    if (self.isUserInfoLoading) {
        return;
    }
    self.isUserInfoLoading = YES;
    if (!self.business) {
        [self setupBusiness];
    }
    @weakify(self);
    [self.business fetchRelationInfo:^(BOOL success, SLChatRelationInfo *relationInfo) {
        @strongify(self);
        if (success && [relationInfo isKindOfClass:[SLChatRelationInfo class]]) {
            self.relationInfo = relationInfo;
            [UserCacheMgr saveRelationInfo:self.relationInfo uid:self.targetUid];
        }
        self.isUserInfoLoading = NO;
    }];
}

#pragma mark - Is vip
- (BOOL)isVip
{
    BOOL isVip = NO;
    if (self.relationInfo && [self.relationInfo.isVip integerValue] == 1) {
        isVip = YES;
    } else {
        isVip = ( [self.targetUser.isVip integerValue] == 1 );
    }
    return isVip;
}


@end
