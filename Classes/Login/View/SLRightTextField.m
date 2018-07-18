//
//  SLRightTextField.m
//  test
//
//  Created by chenyh on 2018/7/10.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLRightTextField.h"
#import "ShowVerifycodeAction.h"

CGFloat const kSLRightTextFieldH = 50;

@interface SLRightTextField ()

@end

@implementation SLRightTextField {
    SLVerificationButton *vButton__;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = kGrayWith808080;
        self.lineColor = [UIColor blackColor];
        self.showBottomLine = YES;
    }
    return self;
}

@end

@interface SLVerificationButton ()

@end

@implementation SLVerificationButton

@end
