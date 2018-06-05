//
//  SLPrivateChatViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController.h"
// categories
#import "SLPrivateChatViewController+TableView.h"
#import "SLPrivateChatViewController+InputView.h"
#import "SLPrivateChatViewController+InputMoreCardView.h"
#import "SLPrivateChatViewController+Business.h"
#import "SLPrivateChatViewController+MessageSend.h"
#import "SLPrivateChatViewController+Events.h"
#import "SLPrivateChatViewController+Gesture.h"
#import "SLPrivateChatViewController+MessageReceived.h"
#import "SLPrivateChatViewController+Emoji.h"
#import "SLPrivateChatViewController+Common.h"
#import "SLPrivateChatViewController+UserAndRelationInfo.h"
// managers
#import "SLAudioManager.h"
#import "SLUserCacheManager.h"
// other
#import "SLChatBusiness.h"

@interface SLPrivateChatViewController ()

@end

@implementation SLPrivateChatViewController

#pragma mark - LifeCycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setNavigationTitle:[UserCacheMgr getLocalUserByUid:self.targetUid].nickname];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    [self setup];
    [self.viewDidLoadSignal sendNext:nil];
}
- (void)clickRightButton:(UIButton *)sender;
{
    if(self.isLiveChatRoom){
        if(self.callBackBlock){
            self.callBackBlock(nil);
        }
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;

    [self addKeyBoardObserver];
    [self updateUserInfo];
}



@end
