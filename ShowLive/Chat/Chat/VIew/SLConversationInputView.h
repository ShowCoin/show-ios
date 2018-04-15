//
//  SLConversationInputView.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
/** ConversationInputView显示的类型 */
typedef NS_ENUM(NSUInteger, ConversationInputViewShowType) {
    /** 录音界面 */
    ConversationInputViewShowTypeVoice = 0,
    
    /** 显示了键盘 */
    ConversationInputViewShowTypeKeyboard,
};

@class SLConversationInputView;

@protocol ConversationInputViewDelegate <NSObject>

@optional
- (void)textSendButtonClicked:(SLConversationInputView *)inputView;
- (void)audioSendButtonClicked:(SLConversationInputView *)inputView;
- (void)emojiButtonClicked:(SLConversationInputView *)inputView;
- (void)moreButtonClicked:(SLConversationInputView *)inputView;
- (void)inputViewShowTypeDidChanged:(ConversationInputViewShowType) viewType;
- (void)audioDidStartRecording;
- (void)audioDidStopRecording;
@end
@protocol ConversationInputViewDataSource <NSObject>

@required
-(BOOL)shouldSendAudio;

@end

@interface SLConversationInputView : UIView
@property (nonatomic, weak) id<ConversationInputViewDelegate>delegate;
@property (nonatomic, weak) id<ConversationInputViewDataSource>dataSource;

/**
 *  输入文本框
 */
@property (strong, nonatomic) UITextView *inputTextView;

/**
 *  emoji按钮
 */
@property (nonatomic, strong) UIButton *emojiButton;
/**
 *  消息类型切换按钮
 */
@property (strong, nonatomic) UIButton *msgtypeSwitchButton;
/**
 *  发送按钮
 */
@property (strong, nonatomic) UIButton *moreButton;
/**
 *  录音文件的存储全路径（含文件名）
 */
@property (strong, nonatomic) NSString *audioFullFileName;
/**
 *  用户的输入内容
 */
@property (nonatomic, strong, readonly)NSString *inputText;

/**
 *  标识当前输入类型是否为语音消息，TURE为语音，反之为文本
 */
@property (assign, nonatomic) BOOL isAutioMsg;

@end
