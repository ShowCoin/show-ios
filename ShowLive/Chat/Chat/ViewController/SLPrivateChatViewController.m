//
//  SLPrivateChatViewController.m
//  ShowLive
//
//  Created by 周华 on 2018/4/10.
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
    [self.navigationBarView setRightIconImage:[UIImage imageNamed:@"userhome_avatar_more"] forState:UIControlStateNormal];
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setNavigationTitle:[UserCacheMgr getLocalUserByUid:self.targetUid].nickname];
    [self.navigationBarView setNavigationColor:NavigationColorwihte];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setup];
}
- (void)clickRightButton:(UIButton *)sender;
{
    [PageMgr pushToReportViewController];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;

    [self addKeyBoardObserver];
    [self updateUserInfo];

    // update
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
    [self setupInputView];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
