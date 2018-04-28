//
//  SLSwitchButton.m
//  ShowLive
//
//  Created by gongxin on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLSwitchButton.h"

@implementation SLSwitchButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selected = NO;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self =  [super initWithCoder:aDecoder];
    if (self) {
        self.selected = NO;
    }
    return self;
}

- (void)setNormalImage:(UIImage *)normalImage
{
    _normalImage = normalImage;
    [self setImage:_normalImage forState:UIControlStateNormal];
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    _selectedImage = selectedImage;
    [self setImage:_selectedImage forState:UIControlStateSelected];
}
@end
