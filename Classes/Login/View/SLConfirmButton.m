//
//  SLConfirmButton.m
//  ShowLive
//
//  Created by chenyh on 2018/7/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLConfirmButton.h"

CGFloat const kSLConfirmButtonH = 46;

@implementation SLConfirmButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:kGrayWith808080 forState:UIControlStateDisabled];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.layer.cornerRadius = kSLConfirmButtonH / 2;
    self.layer.masksToBounds = YES;
    self.enabled = NO;
}


@end
