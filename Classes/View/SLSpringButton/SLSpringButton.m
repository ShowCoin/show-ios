//
//  SLSpringBUtton.m
//  test
//
//  Created by chenyh on 2018/6/26.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLSpringButton.h"

@implementation SLSpringButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self setTitleColor:kThemeWhiteColor forState:UIControlStateSelected];
    [self setTitleColor:kThemeAlphWhiteColor forState:UIControlStateNormal];
    [self.titleLabel setFont:Font_Medium(20 * Proportion375)];
    self.selected = NO;
}

/**
 <#Description#>

 @param highlighted <#highlighted description#>
 */
- (void)setHighlighted:(BOOL)highlighted {}


/**
 <#Description#>

 @param selected <#selected description#>
 */
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.userInteractionEnabled = NO;
    
    CGFloat scale = 0.9;
    
    // usingSpringWithDamping的范围为0.0f到1.0f，数值越小「弹簧」的振动效果越明显
    // initialSpringVelocity则表示初始的速度，数值越大一开始移动越快
    [UIView animateWithDuration:0.5 delay:0.05 usingSpringWithDamping:0.45 initialSpringVelocity:1.9 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (selected) {
            self.transform = CGAffineTransformIdentity;
        } else {
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
        }
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}

@end
