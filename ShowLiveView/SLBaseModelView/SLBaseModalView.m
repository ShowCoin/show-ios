//
//  SLBaseModalView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLBaseModalView.h"

@interface  SLBaseModalView()

@property (nonatomic, strong) UIButton *handleView;

@property (nonatomic,assign) BOOL isShow;
@property (nonatomic,assign) NSInteger onceToken;

@end

@implementation  SLBaseModalView
{
    CGFloat  mViewHeight;
    UIView * mSuperView;
    NSTimeInterval mTimeInterval;
}

- (instancetype)initWithSuperView:(UIView *)superView
                  animationTravel:(NSTimeInterval)animationTimeravel
                       viewHeight:(CGFloat)height
{
    if (self = [super init]) {
        // init
        [self initHandView];
        
        _onceToken    = 1;
        mSuperView    = superView;
        mTimeInterval = animationTimeravel;
        mViewHeight   = height;
        _isShow       = NO;
        
        _iSResponsHandleButton = YES;
        
        self.frame = CGRectMake(0, superView.height+KTabbarSafeBottomMargin, superView.width, mViewHeight+KTabbarSafeBottomMargin);
        [self initView];
        
    }
    
    return self;
}

#pragma mark -- 公共方法

- (void)show
{
    if (_onceToken) {
        
        [self modalViewDidloade];
        
        _onceToken = 0;
    }
    
    
    [UIView animateWithDuration:0 animations:^{
        
        _handleView.mj_y = 0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:mTimeInterval animations:^{
            
            self.frame = CGRectMake(0, mSuperView.height - mViewHeight, mSuperView.width, mViewHeight);
            
        } completion:^(BOOL finished) {
            
            [self modalViewDidAppare];
            _isShow = YES;
        }];
    }];
    
}

- (void)hide
{
    if (!_iSResponsHandleButton) return;
    
    [self modalViewWillDisappare];
    [UIView animateWithDuration:mTimeInterval animations:^{
        
        self.frame = CGRectMake(0, mSuperView.height, mSuperView.width, mViewHeight);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0 animations:^{
            
            _handleView.mj_y = mSuperView.height;
            
        } completion:^(BOOL finished) {
            
            _isShow = NO;
            
        }];
    }];
    
}

- (void)disMiss
{
    if (_isShow) {
        [self hide];
    }
    
    [self removeFromSuperview];
    [self.handleView removeFromSuperview];
    
    self.handleView = nil;
    
}

#pragma mark -- 供子类重写
- (void)initView
{
    // 默认白色
    self.backgroundColor = [UIColor whiteColor];
}

- (void)modalViewDidAppare
{
    
}

- (void)modalViewWillDisappare
{
    
}

- (void)modalViewDidloade
{
    
}

- (void)initHandView
{
    _handleView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //整个页面都是触发消失的button
    [_handleView setFrame:CGRectMake(0, KScreenHeight, KScreenWidth,KScreenHeight)];
    [_handleView setBackgroundColor:[UIColor clearColor]];
    [_handleView addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [_handleView addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:_handleView];
 
}
@end
