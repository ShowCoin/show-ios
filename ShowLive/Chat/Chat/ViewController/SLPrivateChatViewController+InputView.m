//
//  SLPrivateChatViewController+InputView.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController+InputView.h"
#import "SLPrivateChatViewController+Business.h"
#import "SLPrivateChatViewController+TableView.h"
#import "SLPrivateChatViewController+MessageSend.h"
#import "SLPrivateChatViewController+Common.h"
#import "SLPrivateChatViewController+Emoji.h"
#import "SLPrivateChatViewController+InputMoreCardView.h"
#import <AVFoundation/AVFoundation.h>
@implementation SLPrivateChatViewController (InputView)
- (void)setupInputView
{
    SLConversationInputView *inputView =  [[SLConversationInputView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), kScreenWidth, _GetChatInputViewHeight())];
    inputView.delegate = self;
    inputView.dataSource = self;
    inputView.inputTextView.delegate = self;
    self.chatInputView = inputView;
    [self.view addSubview:inputView];
    self.msgSendTimeBuffer = [NSMutableArray arrayWithCapacity:10];
    
    [self updateWithDraft];
}

- (void)updateWithDraft
{
    NSString *draft = [self getInputTextDraft];
    if (IsValidString(draft)) {
        self.chatInputView.inputTextView.text = draft;
        [self textViewDidChange:self.chatInputView.inputTextView];
        [self.chatInputView.inputTextView scrollRangeToVisible:(NSRange){draft.length, 1}];
    }
}

- (void)callUpKeyboardWhenDraftExistAfterUpdateDraft
{
    if (IsValidString(self.chatInputView.inputTextView.text)) {
        [self.chatInputView.inputTextView becomeFirstResponder];
    }
}
#pragma mark - Keyboard Observer
- (void)addKeyBoardObserver
{
    [self removeKeyBoardObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyBoardObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardShow:(NSNotification *)note
{
    self.isInputMoreCardViewShow = NO;
    self.isEmojiViewShow = NO;
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    [self bottomViewAnmimation:YES duration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] distance:deltaY option:[note.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue]];
}

-(void)keyboardHide:(NSNotification *)note
{
    [self bottomViewAnmimation:NO duration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] distance:0 option:[note.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue]];
}

-(void)bottomViewAnmimation:(BOOL)isShow duration:(CGFloat)duration distance:(CGFloat)distance option:(int)option{
    if (isShow) {
        CGFloat bottomH = _GetChatInputViewHeight();
        // minH 形变后 高度
        CGFloat minH =  kScreenHeight - kNaviBarHeight  - bottomH - distance ;
        // maxH 未形变 高度
        CGFloat maxH = kScreenHeight- kNaviBarHeight - bottomH;
        
        // content 高度
        CGFloat contentH = self.tableView.contentSize.height + self.tableView.contentInset.top + self.tableView.contentInset.bottom;
        [self scrollToBottomAnimated:YES];
        
        CGFloat move = 0;
        CGFloat newH = minH;
        if (contentH > minH) {
            move = contentH - minH ;
            move = move > distance ? distance : move;
            newH = contentH < maxH ? contentH : maxH;
        }
        CGRect frame = self.tableView.frame;
        frame.size.height = newH ;
        
        [UIView animateWithDuration:duration delay:0 options:option animations:^{
            self.tableView.frame = frame;
            self.chatInputView.transform=CGAffineTransformMakeTranslation(0, -distance + KTabbarSafeBottomMargin);
            self.tableView.transform = CGAffineTransformMakeTranslation(0, -move);
            
        } completion:nil];
    }else{
        CGRect frame = self.tableView.frame;
        if (distance == 0) {
            frame.size.height = kScreenHeight- _GetChatInputViewHeight() - kNaviBarHeight - KTabbarSafeBottomMargin;
        }
        [UIView animateWithDuration:duration delay:0 options:option animations:^{
            self.tableView.frame = frame;
            self.chatInputView.transform=CGAffineTransformIdentity;
            self.tableView.transform=CGAffineTransformIdentity;
        } completion:nil];
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self sendInputStateMessageWithType:SLRCInputMessageInputStateTypeText];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self sendInputStateMessageWithType:SLRCInputMessageInputStateTypeNone];
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize size = [textView sizeThatFits:textView.frame.size];
    if (size.height > 110) {
        if (CGRectGetHeight(textView.frame) >110) {
            return;
        }else{
            size.height = 110;
        }
    }
    if (size.height < 40) {
        size.height = 35;
    }
    CGFloat textViewH = textView.frame.size.height;
    CGFloat moveH = size.height - textViewH;
    
    if (moveH == 0 || fabs(moveH) <15) {
        return;
    }
    //    // TODO:这里再看一下
    //    if (fabs(moveH) <18) {
    //        textView.height = size.height;
    //        self.chatInputView.height = MAX(size.height + 18, _GetChatInputViewHeight());
    //        return;
    //    }
    
    CGRect bottomF = self.chatInputView.frame;
    bottomF.origin.y -= moveH;
    bottomF.size.height += moveH;
    CGRect textF = textView.frame;
    textF.size.height += moveH;
    CGRect tableF = self.tableView.frame;
    tableF.origin.y -= moveH;
    textView.frame = textF;
    
    CGRect switchButtonF = self.chatInputView.msgtypeSwitchButton.frame;
    switchButtonF.origin.y += moveH;
    
    CGRect giftButtonF = self.chatInputView.emojiButton.frame;
    giftButtonF.origin.y += moveH;
    
    CGRect moreButtonF = self.chatInputView.moreButton.frame;
    moreButtonF.origin.y += moveH;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.tableView.frame = tableF;
        self.chatInputView.frame =bottomF;
        self.chatInputView.msgtypeSwitchButton.frame = switchButtonF;
        self.chatInputView.emojiButton.frame = giftButtonF;
        self.chatInputView.moreButton.frame = moreButtonF;
        
    }];
    [textView scrollRangeToVisible:textView.selectedRange];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //实现textView.delegate  实现回车发送,return键发送功能
    if ([@"\n" isEqualToString:text]) {
        [self sendTextActionIfNeed];
        return NO;
    }
    [self sendInputStateMessageWithType:SLRCInputMessageInputStateTypeText];
    return YES;
}

#pragma mark - ConversationInputViewDelegate
- (void)moreButtonClicked:(SLConversationInputView *)inputView
{
    self.isInputMoreCardViewShow = !self.isInputMoreCardViewShow;// 暂时
}

-(void)audioSendButtonClicked:(SLConversationInputView *)inputView
{
    self.isInputMoreCardViewShow = NO;
    self.isEmojiViewShow = NO;
    NSString *path = inputView.audioFullFileName;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *strAudioPath = path;
        NSDictionary *options = @{ AVURLAssetPreferPreciseDurationAndTimingKey : @(YES) };
        AVURLAsset* audioAsset=[AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:strAudioPath] options:options];
        @weakify(self);
        [audioAsset loadValuesAsynchronouslyForKeys:@[@"playable", @"duration"] completionHandler:^{
            if (audioAsset.playable) {
                @strongify(self);
                CMTime audioDuration = audioAsset.duration;
                //消息的单位是毫秒，所以取到的秒数乘以1000
                float audioDurationSeconds = CMTimeGetSeconds(audioDuration) * NSEC_PER_USEC;
                if (audioDurationSeconds >= 1000) {
                    [self sendVoiceMessageWithVoicePath:path duration:audioDurationSeconds];
                }else{
                    [ShowWaringView waringView:@"录音太短，应该大于1秒" style:WaringStyleRed];
                }
            }else{
                [ShowWaringView waringView:@"录音失败，请重试" style:WaringStyleRed];
            }
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }];
    });
}

- (void)audioDidStartRecording
{
    [self sendInputStateMessageWithType:SLRCInputMessageInputStateTypeVoice];
}

- (void)audioDidStopRecording
{
    [self sendInputStateMessageWithType:SLRCInputMessageInputStateTypeNone];
}

-(void)inputViewShowTypeDidChanged:(ConversationInputViewShowType)viewType
{
    self.isInputMoreCardViewShow = NO;
    self.isEmojiViewShow = NO;
    if (viewType == ConversationInputViewShowTypeKeyboard) {
        self.chatInputView.inputTextView.text = self.textString;
    }else {
        self.textString = self.chatInputView.inputTextView.text;
        self.chatInputView.inputTextView.text = @"";
    }
    [self textViewDidChange:self.chatInputView.inputTextView];
}

-(void)emojiButtonClicked:(SLConversationInputView *)inputView
{
    self.isEmojiViewShow = !self.isEmojiViewShow;
}

#pragma mark - SLConversationInputViewDataSource
-(BOOL)shouldSendAudio
{
    return YES;
}

#pragma mark - Private Messages Checkout
// TODO:连续发送防打扰逻辑:1分钟内A用户向B连续发送消息大于等于10条，且B未回复时，提示等待10秒再发送
//检测发送时间限制
-(BOOL)canSendMsgNow
{
    
    if (self.msgSendTimeBuffer.count < 10) {
        return YES;
    }
    
    NSDate *now = [NSDate date];
    if ([now timeIntervalSinceDate:self.msgSendTimeBuffer.firstObject] > 60) {
        return YES;
    }
    
    if ([now timeIntervalSinceDate:self.msgSendTimeBuffer.lastObject] > 10) {
        return YES;
    }
    
    return NO;
}

//每发送成功一条消息后，将该消息的发送时间加入buffer，为后续的连续发送消息时间作准备
- (void)addMsgSendTimeAsNow
{
    NSMutableArray *array = self.msgSendTimeBuffer;
    if (array.count >= 10) {
        [array removeObject:array.firstObject];
    }
    [array addObject:[NSDate date]];
}

//收到对方消息回复时，清空当前的消息发送列表，重新计算连续发送防打扰逻辑
-(void)clearMsgSendTimeBuffer
{
    [self.msgSendTimeBuffer removeAllObjects];
}


- (void)sendTextActionIfNeed
{
    NSString *strMsgContent = self.chatInputView.inputText;
    NSUInteger originLen = strMsgContent.length;
    strMsgContent = [strMsgContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSUInteger strLen = strMsgContent.length;
    if (strLen > 0)
    {
        if (strLen <= 1000) {
            if ([self canSendMsgNow]) {
                [self sendText:strMsgContent];
            }else{
                [ShowWaringView waringView:@"消息发送过为频繁，请稍后再发" style:WaringStyleRed];
            }
            
        }else{
            [ShowWaringView waringView:@"文本过长，请输入1000字以内" style:WaringStyleRed];
            self.chatInputView.inputTextView.text=strMsgContent;
        }
    }else if (originLen > 0){
        [self clearInputText];
        [ShowWaringView waringView:@"不能发送空白消息" style:WaringStyleRed];
    }
}

- (void)sendText:(NSString *)string
{
    NSString *text = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!IsValidString(text)) {
        [self clearInputText];
        [ShowWaringView waringView:@"不能发送空白消息" style:WaringStyleRed];
        return;
    }
    
    BOOL containSensitiveWord = [self isContainSensitiveWords:text];
    [self clearInputText];
    if (!containSensitiveWord) {
        [self addMsgSendTimeAsNow];
        [self sendTextMessageWithText:text];
    } else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"消息中存在不良信息，请文明聊天，否则可能会被封号处理" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        @weakify(self);
        UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            [self sendTextMessageWithText:text];
        }];
        [alertController addAction:cancel];
        [alertController addAction:settingsAction];
        [self presentViewController:alertController animated:YES completion:^{}];
    }
}

- (BOOL)isContainSensitiveWords:(NSString *)string{
    NSArray *arr = @[];//SysConfig.sensitiveWords;
    BOOL contain = NO;
    for (NSString *word in arr) {
        NSRange range = [string rangeOfString:word];
        if (range.length >0) {
            contain = YES;
            break;
        }
    }
    return contain;
}

- (void)clearInputText
{
    dispatch_block_t block = ^{
        self.chatInputView.inputTextView.text = @"";
        self.textString = @"";
        [self textViewDidChange:self.chatInputView.inputTextView];
    };
    dispatch_main_sync_safe(block);
}

#pragma mark - Responder
- (BOOL)isChatViewFirstResponder
{
    return self.chatInputView.inputTextView.isFirstResponder;
}

- (void)resignChatViewFirstResponder
{
    if ([self isChatViewFirstResponder]) {
        [self.chatInputView.inputTextView resignFirstResponder];
    }
}

@end
