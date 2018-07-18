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

@end
