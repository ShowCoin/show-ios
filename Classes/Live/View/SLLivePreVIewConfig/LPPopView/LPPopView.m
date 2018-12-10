//
//  LPPopView.m
//  Edu
//
//  Created by chenyh on 2018/9/20.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "LPPopView.h"

@implementation LPPopView

@synthesize animating = _animating;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        self.layer.anchorPoint = CGPointMake(0.5, 0);        
    }
    return self;
}

#pragma mark - Method

- (void)sl_show:(BOOL)show complete:(void(^)(void))cmp {
    self->_animating = YES;
    
}

@end
