//
//  SLInputBar.h
//  ShowLive
//
//  Created by gongxin on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLInputTextView.h"
#import "SLSwitchButton.h"
@interface SLInputBar : UIView

@property(nonatomic,strong) SLInputTextView * textView;

@property(nonatomic,strong) SLSwitchButton *danmuBtn;

@property(nonatomic,strong)UIButton * sendButton;

@end
