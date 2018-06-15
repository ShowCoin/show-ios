//
//  SLVolumeView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/28.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLVolumeView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPVolumeView.h>
@interface SLVolumeView ()
@property (nonatomic, assign)BOOL isShowing;
@property(nonatomic,assign)NSInteger notiCount;

@end

@implementation SLVolumeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        _notiCount = 0;
        
    
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        [self addSubview:self.fillView];
        [self addNotifi];
        _isShowing = NO;
        self.fillView.alpha = 0.0;
    }
    
    return self;
}



@end
