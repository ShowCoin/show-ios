//
//  SLConfirmButton.m
//  ShowLive
//
//  Created by chenyh on 2018/7/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLConfirmButton.h"

CGFloat const kSLConfirmButtonH = 46;

/**
 SLConfirmButton
 */
@implementation SLConfirmButton

/**
 initWithFrame

 @param frame <#frame description#>
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

/**
 setupUI
 */
- (void)setupUI {
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:kGrayWith808080 forState:UIControlStateDisabled];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.layer.cornerRadius = kSLConfirmButtonH / 2;
    self.layer.masksToBounds = YES;
    self.enabled = NO;
}

/**
 <#Description#>

 @param enabled <#enabled description#>
 */
- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    // 不可点击状态 按钮底色是#1e1e1e 字体颜色#808080
    // 可点击状态 按钮底色是#333333 字体是白色
    if (enabled) {
        self.backgroundColor = kthemeBlackColor;
    } else {
        self.backgroundColor = HexRGBAlpha(0x1e1e1e, 1);
    }
}

@end
