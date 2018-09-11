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


@end
