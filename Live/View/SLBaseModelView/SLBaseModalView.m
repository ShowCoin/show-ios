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

@property (nonatomic,assign)CGFloat  mViewHeight;
@property (nonatomic,strong)UIView * mSuperView;
@property (nonatomic,assign)NSTimeInterval mTimeInterval;

@end

@implementation  SLBaseModalView

- (instancetype)initWithSuperView:(UIView *)superView
                  animationTravel:(NSTimeInterval)animationTimeravel
                       viewHeight:(CGFloat)height
{
    if (self = [super init]) {
        // init
        [self initHandView];
        
        _onceToken    = 1;
        _mSuperView    = superView;
         _mTimeInterval = animationTimeravel;
         _mViewHeight   = height;
        _isShow       = NO;
        
        _iSResponsHandleButton = YES;
        
        self.frame = CGRectMake(0, superView.height+KTabbarSafeBottomMargin, superView.width, _mViewHeight+KTabbarSafeBottomMargin);
        [self initView];
        
    }
    
    return self;
}

#pragma mark -- 公共方法

- (void)show
{
    [HDHud hideHUD];
    
    if (_onceToken) {
        
        [self modalViewDidloade];
        
        _onceToken = 0;
    }
    
    @weakify(self);

    [UIView animateWithDuration:0 animations:^{
            @strongify(self);
        self.handleView.mj_y = 0;
        
    } completion:^(BOOL finished) {
                @strongify(self);
        [UIView animateWithDuration:self.mTimeInterval animations:^{
            @strongify(self);
            self.frame = CGRectMake(0,self.mSuperView.height - self.mViewHeight,self. mSuperView.width, self.mViewHeight);
            
        } completion:^(BOOL finished) {
            @strongify(self);
            [self modalViewDidAppare];
            self.isShow = YES;
        }];
    }];
    
}




- (void)hide
{
    if (!_iSResponsHandleButton) return;
    
    [self modalViewWillDisappare];
        @weakify(self);
    [UIView animateWithDuration:self.mTimeInterval animations:^{
          @strongify(self);
        self.frame = CGRectMake(0, self.mSuperView.height, self.mSuperView.width, self.mViewHeight);
        
    } completion:^(BOOL finished) {
        @strongify(self);
        [UIView animateWithDuration:0 animations:^{
            
            self.handleView.mj_y = self.mSuperView.height;
            
        } completion:^(BOOL finished) {
            
            self.isShow = NO;
            
        }];
    }];
    
}

- (void)disMiss
{
    if (_isShow) {
        [self hide];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        [self.handleView removeFromSuperview];
        self.handleView = nil;
    });

}

#pragma mark -- 供子类重写
- (void)initView
{
    // 默认白色
    self.backgroundColor = [UIColor clearColor];
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
