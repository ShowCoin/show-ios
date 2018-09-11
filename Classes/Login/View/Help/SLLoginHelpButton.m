//
//  SLLoginHightButton.m
//  Edu
//
//  Created by chenyh on 2018/9/7.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLLoginHelpButton.h"

@interface SLLHBAniDelegate : NSObject <CAAnimationDelegate>

@property (nonatomic, copy) SLSimpleBlock aniblock;

@end

@implementation SLLHBAniDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.aniblock) {
        self.aniblock();
    }
}

@end

@interface SLLoginHelpButton ()
@property (nonatomic, strong) SLLHBAniDelegate *delegate;
@end

@implementation SLLoginHelpButton

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [self blackColor];
        [self setTitle:@"帮助" forState:UIControlStateNormal];
        [self setTitleColor:kGrayWith676767 forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont sl_fontMediumOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

        self.layer.cornerRadius = 14;
        self.layer.masksToBounds = YES;
    }
    return self;
}


@end
