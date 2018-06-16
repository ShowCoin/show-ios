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


-(void)dealloc
{
    //    self.fillView.hidden = YES;
    //    [self.fillView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)addNotifi
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    
}

-(void)volumeChanged:(NSNotification *)notification{
    
    _notiCount++;
    
    if (_notiCount<3) {
        return;
    }
    
    self.fillView.hidden = NO;
    self.fillView.alpha = 1;
    self.isShowing = YES;
    [self animateHide];
    float volume = [[[notification userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    [self setProgressMaxValue:1.0 CurrentValue:volume];
    
}

- (void)animateHide
{
    if (!self.isShowing) {
        return;
    }
    @weakify(self)
    [UIView animateWithDuration:3 animations:^{
        @strongify(self)
        self.fillView.alpha = 0.0;
    } completion:^(BOOL finished) {
        @strongify(self)
        self.isShowing = NO;
    }];
    
    
}


/**
 <#Description#>

 @param maxValue <#maxValue description#>
 @param currentValue <#currentValue description#>
 */
- (void)setProgressMaxValue:(float)maxValue
               CurrentValue:(float)currentValue
{
    
}

-(UIView*)fillView
{
    if(!_fillView)
    {
        _fillView = [[UIView alloc]initWithFrame:CGRectZero];
        _fillView.backgroundColor = [UIColor whiteColor];
        _fillView.hidden = YES;
    }
    return _fillView;
}


@end
