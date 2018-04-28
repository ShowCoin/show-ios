//
//  SLPrivateChatViewController+Events.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLPrivateChatViewController.h"
#import "SLChatMessageCellHeader.h"
@class SLPreviewMagicAnimatorNavigationDelegate;
@interface SLPrivateChatViewController()<TZImagePickerControllerDelegate>
@property (strong, nonatomic) SLPreviewMagicAnimatorNavigationDelegate *animatorDelegate;
@end

@interface SLPrivateChatViewController (Events)
- (void)pushToConfigVC;
- (void)pushToUserCenter:(id<SLChatMessageBaseCellViewModel>)viewModel;

// Cell click actions
- (void)handleVoiceCellContentClickWithCell:(id<SLChatVoiceMessageCellProtocol>)cell viewModel:(id<SLChatVoiceMessageCellViewModel>)viewModel;

// Actions
- (void)handleVideoRecordingAction;
- (void)handleLocationSendAction;
- (void)handleSendDiceMessageAction;

@end
