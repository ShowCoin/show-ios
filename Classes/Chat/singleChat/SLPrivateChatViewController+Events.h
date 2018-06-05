//
//  SLPrivateChatViewController+Events.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController.h"
#import "SLChatMessageCellHeader.h"
@class SLPreviewMagicAnimatorNavigationDelegate;
@interface SLPrivateChatViewController()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) SLPreviewMagicAnimatorNavigationDelegate *animatorDelegate;
@end

@interface SLPrivateChatViewController (Events)
- (void)pushToConfigVC;
- (void)pushToUserCenter:(id<SLChatMessageBaseCellViewModel>)viewModel;

// Cell click actions
- (void)handleRichCellContentClickWithCell:(id<SLChatRichMessageCellProtocol>)cell viewModel:(id<SLChatRichMessageCellViewModel>)viewModel;

- (void)handleVoiceCellContentClickWithCell:(id<SLChatVoiceMessageCellProtocol>)cell viewModel:(id<SLChatVoiceMessageCellViewModel>)viewModel;

// Actions
- (void)handleVideoRecordingAction;
- (void)handleLocationSendAction;
- (void)handleSendDiceMessageAction;

@end
