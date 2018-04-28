//
//  SLInputBar.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/12.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLInputBar.h"

@interface SLInputBar ()

@property (nonatomic,strong)UIView * inputBackView;

@end

@implementation SLInputBar

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
     
        [self addSubview:self.inputBackView];
        [self addSubview:self.danmuBtn];
        [self addSubview:self.textView];
        [self addSubview:self.sendButton];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
    
}

-(SLInputTextView*)textView
{
    if (!_textView) {
        _textView=[[SLInputTextView alloc]initWithFrame:CGRectMake(75,8, kScreenWidth-189,34)];
        _textView.backgroundColor=[UIColor clearColor];
        _textView.showsVerticalScrollIndicator = NO;
        _textView.font=[UIFont systemFontOfSize:15];
        _textView.textColor= Color(@"262626");
        _textView.returnKeyType=UIReturnKeySend;
        _textView.placeholder       = @"说点什么吧";
        _textView.placeholderColor  = Color(@"999999");
        _textView.placeholdFont     = [UIFont systemFontOfSize:15];
        _textView.tintColor = [UIColor blackColor];
        _textView.keyboardType = UIKeyboardTypeDefault;
    
    }
    return _textView;
}

-(SLSwitchButton*)danmuBtn
{
    if (!_danmuBtn) {
        _danmuBtn = [[SLSwitchButton alloc]initWithFrame:CGRectMake(14, 11, 50, 28)];
        _danmuBtn.normalImage = [UIImage imageNamed:@"input_danmu_off"];
        _danmuBtn.selectedImage = [UIImage imageNamed:@"input_danmu_on"];
        
    }
    return _danmuBtn;
}


-(UIView*)inputBackView
{
    if (!_inputBackView) {
        _inputBackView = [[UIView alloc]initWithFrame:CGRectMake(10, 8, kScreenWidth-86, 34)];
        _inputBackView.backgroundColor = Color(@"f9f9f9");
        _inputBackView.layer.masksToBounds = YES;
        _inputBackView.layer.cornerRadius = 17;
        _inputBackView.layer.borderWidth = 0.5;
        _inputBackView.layer.borderColor = [Color(@"000000") colorWithAlphaComponent:0.07].CGColor;
    }
    return _inputBackView;
}

-(UIButton*)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake(kScreenWidth-66,11, 50, 28);
        _sendButton.backgroundColor = [UIColor orangeColor];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendButton.layer.cornerRadius =14;
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _sendButton;
}


@end
