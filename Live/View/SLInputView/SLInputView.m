//
//  SLInputView.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/12.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLInputView.h"
#import "SLInputBar.h"
#import <IQKeyboardManager.h>
@interface SLInputView ()<UITextViewDelegate>

@property (strong,nonatomic) SLInputBar * toolBar;

@end
@implementation SLInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.toolBar];
        [self addNotifation];
        [self initComponents];
    }
    return self;
    
}

-(void)initComponents
{
    [self.toolBar.danmuBtn addTarget:self action:@selector(onSwitchDanmuButton) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)onSwitchDanmuButton
{
    self.toolBar.danmuBtn.selected = !self.toolBar.danmuBtn.selected;

}

-(void)dealloc
{
    [self removeNotifation];
    NSLog(@"[gx] inputview dealloc");
}

-(void)addNotifation
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}
-(void)removeNotifation
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    
    if (!self.window) {
        return;//如果当前vc不是堆栈的top vc，则不需要监听
    }
    
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        
        return;
    }
    
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame   = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration  = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = (UIViewAnimationCurve)[userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    @weakify(self);
    void(^animations)(void) = ^{
        @strongify(self);
        [self willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    };
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:nil];
}

- (void)willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame
{
    
    if (toFrame.origin.y == [[UIScreen mainScreen] bounds].size.height) {
        
        [self willShowBottomHeight:0];
        
    }else{
        if(![self.toolBar.textView isFirstResponder]){
            return ;
        }
        [self willShowBottomHeight:toFrame.size.height];
        
    }
    
}
- (void)willShowBottomHeight:(CGFloat)bottomHeight
{
    NSLog(@"[gx] willShowBottomHeight:%f",bottomHeight);
    CGRect fromFrame = self.frame;
    CGFloat toHeight = 50 + bottomHeight;
    CGRect toFrame = CGRectMake(fromFrame.origin.x, fromFrame.origin.y + (fromFrame.size.height - toHeight), fromFrame.size.width, toHeight);
     self.frame = toFrame;

    //改变外部控件的y
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputViewHeightChange:)]) {
        [self.delegate inputViewHeightChange:toHeight];
    }
    
    
    if (bottomHeight == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(hideInputView)]) {
            [self.delegate hideInputView];
        }

    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(showInputView)]) {
            [self.delegate showInputView];
        }
    }
}

-(void)beginChat
{

    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self.toolBar.textView becomeFirstResponder];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if (text.length > 40) {
        return NO;
    }

    if ([text isEqualToString:@"\n"])
    {
        [self sendText:textView.text];

        return NO;
    }
    
    return YES;
}


//发送消息
-(void)sendText:(NSString*)text
{
    if (self.toolBar.danmuBtn.selected&&AccountUserInfoModel.showCoinNum.integerValue==0) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"余额不足,前往充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立刻充值", nil];
        [alert show];
        return;
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(sendText:isPay:)]) {
        [self.delegate sendText:text isPay:self.toolBar.danmuBtn.selected];
         self.toolBar.textView.text = @"";
    }
}


-(void)sendButtonClick:(UIButton*)sender
{
    [self sendText:self.toolBar.textView.text];
}

-(SLInputBar*)toolBar
{
    if (!_toolBar) {
        _toolBar = [[SLInputBar alloc]initWithFrame:CGRectMake(0, 50, self.width, 53)];
        _toolBar.textView.delegate = self;
    }
    return _toolBar;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [PageMgr pushToWalletController];
    }
}

@end
