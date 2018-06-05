//
//  SLPrivateChatViewController+InputView.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController.h"
#import "SLConversationInputView.h"
@interface SLPrivateChatViewController()
@property (strong, nonatomic) SLConversationInputView *chatInputView;
@property (nonatomic, strong) NSString *textString;
@property (strong, nonatomic) NSMutableArray *msgSendTimeBuffer;
// 顶部输入状态，为nil说明停止输入
@property (copy, nonatomic) NSString *titleViewChatInputStateString;

@end
@interface SLPrivateChatViewController (InputView)<ConversationInputViewDelegate,ConversationInputViewDataSource,UITextViewDelegate>
- (void)setupInputView;
- (void)addKeyBoardObserver;
- (void)removeKeyBoardObserver;
- (void)clearInputText;
- (void)addMsgSendTimeAsNow;
- (BOOL)isChatViewFirstResponder;
- (void)resignChatViewFirstResponder;
- (void)callUpKeyboardWhenDraftExistAfterUpdateDraft;
- (void)clearMsgSendTimeBuffer;
- (void)sendTextActionIfNeed;

@end
