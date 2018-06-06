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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self sendReceivedMessageReadReceiptWithLastSentTimeInDataBase];
    [self findAndSetUnreadMessageAfterViewDidApperar];
    [self callUpKeyboardWhenDraftExistAfterUpdateDraft];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self saveInputTextToDraft];
    
    self.isInputMoreCardViewShow = NO;
    self.isEmojiViewShow = NO;
    
    // clear all message`s unread state
    [self clearConversationMessageUnreadState];
    [self setLastestMessageToReadState];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[SLAudioManager sharedManager] stopAudio];
    
    [self resignChatViewFirstResponder];
    [self removeKeyBoardObserver];
}

#pragma mark - Private Setup
- (void)setup
{
    // setup
    [self setupBusiness];
    [self setupChatTableView];
    if (!self.isSYSTEMMessage) {
        [self setupInputView];
    }
    //    [self setupNavigationBar];
    
    [self setupGestures];
    [self setupMenuItems];
    self.neverSendMessageSinceCome = YES;
    
    // load data
    [self loadMessageData];
    [self scrollToBottomAnimated:YES];
    [self addMessageReceivedObservers];
    [self addNetStatusObserver];
    // start
}
#pragma mark - Setter

-(void)setTargetUid:(NSString *)targetUid
{
    _targetUid = targetUid;
}

- (void)setTargetUser:(ShowUserModel *)targetUser
{
    _targetUser = targetUser;
    // 如果不存在，更新
    if (![UserCacheMgr getLocalUserByUid:targetUser.uid]) {
        [UserCacheMgr updateUser:targetUser];
    } else if(!IsValidString(targetUser.nickname) ||
              !IsValidString(targetUser.remarkName)){
        // 昵称或备注不完整，重新获取
        ShowUserModel *user = [UserCacheMgr getLocalUserByUid:targetUser.uid];
        if (user) {
            _targetUser = user;
        } else {
            [self updateUserInfo];
        }
    }
    _targetUid = _targetUser.uid;
}

- (BOOL)isSYSTEMMessage
{
    return [self.targetUid isEqualToString:kSystemNumber_RongCloud];
}

@end
