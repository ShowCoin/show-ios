//
//  SLConversationInputView.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLConversationInputView.h"
#import "SLAudioManager.h"
#import "SLChatRecordStateHud.h"
#import "UITextView+Placeholder.h"
@interface SLConversationInputView (AudioRecording)
- (void)startRecording;
- (void)sendRecording;
- (void)stopRecording;
- (BOOL)canRecord;
- (void)showNotPermissionWarningAlert;
@end
@interface SLConversationInputView()<UITextViewDelegate>
/**
 *  录音按钮
 */
@property (strong, nonatomic) UIButton *audioRecordButton;

/**
 *  发语音时的提示view
 */
@property (nonatomic, strong) UIView *voiceNoticeView;
/**
 *  发语音时的提示icon
 */
@property (nonatomic, strong) UIImageView *voiceNoticeIcon;
/**
 *  发语音时的提示语显示label
 */
@property (nonatomic, strong) UILabel *voiceNoticeLabel;

@property (nonatomic, assign) BOOL isRecordingPermissionWarningAlertShow;

@end
@implementation SLConversationInputView
#pragma mark - Life Cycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowOffset = CGSizeMake(frame.size.width, -2);
        self.layer.shadowColor = RGBACOLOR(255, 255, 255, 0.2).CGColor;
        [self setupUI];
    }
    return self;
}

#pragma mark - Private setup UI
-(void)setupUI
{
    [self addSubview:self.msgtypeSwitchButton];
    [self addSubview:self.inputTextView];
    [self addSubview:self.audioRecordButton];
    self.audioRecordButton.hidden = YES;
    [self addSubview:self.moreButton];
    [self addSubview:self.emojiButton];
    
    // 各个空间间隔
    CGFloat hPadding = 13;
    self.msgtypeSwitchButton.frame = (CGRect){0, 0, 54, 50};
    self.moreButton.frame = (CGRect){kScreenWidth - 34 - (hPadding - 5), 0, 34, 50};
    self.emojiButton.frame = (CGRect){self.moreButton.left - 34 - (hPadding - 10), 0 , 34, 50};
    self.inputTextView.frame = (CGRect){CGRectGetMaxX(self.msgtypeSwitchButton.frame), 9, self.emojiButton.left - hPadding - self.msgtypeSwitchButton.right, 50 - 9*2};
    self.audioRecordButton.frame = self.inputTextView.frame;
}

#pragma mark - Getter
-(UIButton *)msgtypeSwitchButton
{
    if (!_msgtypeSwitchButton) {
        _msgtypeSwitchButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_msgtypeSwitchButton setImage:[UIImage imageNamed:@"yuyin_icon"] forState:UIControlStateNormal];
        [_msgtypeSwitchButton addTarget:self action:@selector(didClickChangeTypeButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _msgtypeSwitchButton;
}

-(UITextView *)inputTextView
{
    if (!_inputTextView) {
        UITextView *textView = [[UITextView alloc] init];
        if (@available(iOS 11.0, *)) {
            textView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        textView.backgroundColor = [UIColor clearColor];
        textView.placeholderColor = RGBCOLOR(182, 182, 182);
        textView.placeholder = @"说点什么...";
        textView.placeholderLabel.font = [UIFont systemFontOfSize:15];
        textView.backgroundColor = [UIColor clearColor];
        textView.font = [UIFont systemFontOfSize:15];
        textView.textColor = kthemeBlackColor;
        textView.returnKeyType = UIReturnKeySend;
        textView.layoutManager.allowsNonContiguousLayout = NO;
        textView.showsHorizontalScrollIndicator = NO;
        textView.showsVerticalScrollIndicator = NO;
        textView.clipsToBounds = YES;
        _inputTextView = textView;
    }
    return _inputTextView;
}

-(UIButton *)audioRecordButton
{
    if (!_audioRecordButton) {
        _audioRecordButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _audioRecordButton.backgroundColor = [UIColor clearColor];
        _audioRecordButton.layer.borderWidth = 1.0f;
        _audioRecordButton.layer.borderColor = RGBCOLOR(230, 230, 230).CGColor;
        [_audioRecordButton setTitleColor:kthemeBlackColor forState:UIControlStateNormal];
        _audioRecordButton.layer.cornerRadius = 6;
        [_audioRecordButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_audioRecordButton setTitle:@"按住说话" forState:UIControlStateNormal];
        [_audioRecordButton addTarget:self action:@selector(didClickAudioRecordButton) forControlEvents:UIControlEventTouchUpInside];
        [_audioRecordButton addTarget:self action:@selector(audioButtonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [_audioRecordButton addTarget:self action:@selector(audioButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_audioRecordButton addTarget:self action:@selector(audioButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [_audioRecordButton addTarget:self action:@selector(audioButtonTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [_audioRecordButton addTarget:self action:@selector(audioButtonTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    }
    return _audioRecordButton;
}

-(UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_moreButton setImage:[UIImage imageNamed:@"conv_more_card"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(didClicSLoreButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}


-(UIButton *)emojiButton
{
    if (!_emojiButton) {
        _emojiButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _emojiButton.clipsToBounds = NO;
        [_emojiButton setImage:[UIImage imageNamed:@"m_emoji_icon"] forState:UIControlStateNormal];
        [_emojiButton addTarget:self action:@selector(didClickEmojiButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiButton;
}

#pragma mark - getter and setter

-(NSString *)inputText
{
    return self.inputTextView.text;
}

-(void)setIsAutioMsg:(BOOL)isAutioMsg
{
    _isAutioMsg = isAutioMsg;
    self.inputTextView.hidden = _isAutioMsg;
    self.audioRecordButton.hidden = !_isAutioMsg;
    UIImage *audioImg = _isAutioMsg ? [UIImage imageNamed:@"keyboard_msg"] : [UIImage imageNamed:@"yuyin_icon"];
    [_msgtypeSwitchButton setImage:audioImg forState:UIControlStateNormal];
    
}
#pragma mark - Actions
-(void)didClickChangeTypeButton
{
    [self endEditing:YES];
    self.isAutioMsg = !self.isAutioMsg;
    if (!self.isAutioMsg) {
        [self.inputTextView becomeFirstResponder];
    }
    if ([self.delegate respondsToSelector:@selector(inputViewShowTypeDidChanged:)]) {
        [self.delegate inputViewShowTypeDidChanged:(self.isAutioMsg ? ConversationInputViewShowTypeVoice : ConversationInputViewShowTypeKeyboard)];
    }
}

-(void)didClicSLoreButton
{
    [self resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(moreButtonClicked:)]) {
        [self.delegate moreButtonClicked:self];
    }
}

-(void)didClickEmojiButton
{
    if ([self.delegate respondsToSelector:@selector(emojiButtonClicked:)]) {
        [self.delegate emojiButtonClicked:self];
    }
}

#pragma mark Audio Actions
-(void)didClickAudioRecordButton{
    [self sendRecording];
}

-(void)audioButtonTouchUpOutside:(UIButton *)sender
{
    //取消录音
    [self stopRecording];
}

-(void)audioButtonTouchCancel:(UIButton *)sender
{
    //取消录音
    [self stopRecording];
}

-(void)audioButtonTouchDragEnter:(UIButton *)sender
{
    [SLChatRecordStateHud changeState:SLChatRecordStateRecording];
}

-(void)audioButtonTouchDragExit:(UIButton *)sender
{
    [SLChatRecordStateHud changeState:SLChatRecordStateUpCancel];
}

-(void)audioButtonTouchDown:(UIButton *)sender
{
    [self startRecording];
}

#pragma mark - Notification
//处理融云聊天消息
- (void)notifyRecordTimeLimitOut:(NSNotification *)notification
{
    [self didClickAudioRecordButton];
}

#pragma mark - other methods
- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    return [self.inputTextView resignFirstResponder];
}

//此函数每次调用都会更新audioFullFileName，所以同一个录音只能调用一次
-(NSString *)generateAudioFullFileName
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.audioFullFileName = [NSString stringWithFormat:@"%@/%.0f.wav",docDir, [[NSDate date] timeIntervalSince1970]];
    return self.audioFullFileName;
}

@end

#pragma mark - ConversationInputView(AudioRecording)
@implementation SLConversationInputView(AudioRecording)
- (void)startRecording
{
    if (![self canRecord]) {
        return;
    }
    //开始录音
    if (self.dataSource && [self.dataSource shouldSendAudio]) {
        
        if([[SLAudioManager sharedManager] startRecorderWithFileName:[self generateAudioFullFileName]]){
            [_audioRecordButton setBackgroundColor:RGBCOLOR(238, 238, 238)];
            [_audioRecordButton setTitle:@"松开结束" forState:UIControlStateNormal];
            
            [SLChatRecordStateHud show];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyRecordTimeLimitOut:) name:kNotify_Record_Time_Limit_Out object:nil];
            if ([self.delegate respondsToSelector:@selector(audioDidStartRecording)]) {
                [self.delegate audioDidStartRecording];
            }
        }else{
            NSLog(@"录音启动失败");
        }
    }
}

- (void)sendRecording
{
    [self stopRecording];
    if ([SLAudioManager sharedManager].bRecordSuccess
        && [[NSFileManager defaultManager] fileExistsAtPath:self.audioFullFileName]
        && [SLChatRecordStateHud seconds] > 1) {
        //发送录音
        if ([self.delegate respondsToSelector:@selector(audioSendButtonClicked:)]) {
            [self.delegate audioSendButtonClicked:self];
        }
    }
}

- (void)stopRecording
{
    if (![self canRecord]) {
        return;
    }
    [[SLAudioManager sharedManager] stopRecorder];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotify_Record_Time_Limit_Out object:nil];
    
    [_audioRecordButton setTitle:@"按住说话" forState:UIControlStateNormal];
    _audioRecordButton.backgroundColor = [UIColor clearColor];
    
    if ([SLChatRecordStateHud seconds] > 1) {
        
        [SLChatRecordStateHud dismissWithRecordState:SLChatRecordStateSuccess];
    }else{
        
        [SLChatRecordStateHud dismissWithRecordState:SLChatRecordStateShort];
    }
    if ([self.delegate respondsToSelector:@selector(audioDidStopRecording)]) {
        [self.delegate audioDidStopRecording];
    }
}

- (BOOL)canRecord
{
    BOOL canRecord = [[SLAudioManager sharedManager] canRecord];
    if (!canRecord) {
        [self showNotPermissionWarningAlert];
    }
    return canRecord;
}

- (void)showNotPermissionWarningAlert
{
    if (self.isRecordingPermissionWarningAlertShow) {
        return;
    }
    self.isRecordingPermissionWarningAlertShow = YES;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"SHOW需要访问你的麦克风权限。请点击设置前往系统设置允许Show访问你的麦克风" preferredStyle:UIAlertControllerStyleAlert];
    @weakify_old(self);
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        @strongify_old(self);
        strong_self.isRecordingPermissionWarningAlertShow = NO;
    }];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify_old(self);
        strong_self.isRecordingPermissionWarningAlertShow = NO;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:cancel];
    [alertController addAction:settingsAction];
    [self.viewController presentViewController:alertController animated:YES completion:^{}];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
