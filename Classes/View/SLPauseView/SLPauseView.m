//
//  SLPauseView.m
//  Animation
//
//  Created by 陈英豪 on 2018/5/27.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLPauseView.h"

@interface SLPauseView ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation SLPauseView {
    BOOL canAni;
}

+ (instancetype)shared {
    static SLPauseView *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat w = UIScreen.mainScreen.bounds.size.width;
        CGFloat h = UIScreen.mainScreen.bounds.size.height;
        CGRect frame = CGRectMake(0, 0, w, h);;
        _instance = [[SLPauseView alloc] initWithFrame:frame];
    });
    return _instance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.bounds = CGRectMake(0, 0, 60, 60);
        imageView.center = self.center;
        imageView.alpha = 0;
        imageView.image = [UIImage imageNamed:@"live_center_play"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        self.imageView = imageView;
        canAni = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self show:NO];
}

- (void)show:(BOOL)isShow {
    if (canAni == NO) return;
    [self canAni];
    [UIApplication.sharedApplication.windows.firstObject addSubview:self];
    [UIApplication.sharedApplication.windows.firstObject bringSubviewToFront:self];
    self.alpha = isShow ? 0 : 1;
    NSTimeInterval t = isShow ? 0 : 0.25;
    if (!isShow) [self animatedPlay:NO];
    [UIView animateWithDuration:0.25 delay:t options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha =  isShow ? 1 : 0;
    } completion:^(BOOL finished) {
        if (isShow) {
            [self animatedPlay:YES];
        } else{
            if (self.hiddenBlock) self.hiddenBlock();
            [self removeFromSuperview];
        }
    }];
    [self performSelector:@selector(canAni) withObject:nil afterDelay:0.5];
}

- (void)canAni {
    canAni = !canAni;
}

- (void)animatedPlay:(BOOL)show {
    CGRect frame = self.imageView.frame;
    CGRect endF  = self.imageView.frame;
    if (show) {
        frame.origin.x -= 40;
    } else {
        endF.origin.x += 40;
    }
    self.imageView.frame = frame;
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.frame = endF;
        self.imageView.alpha = show ? 1 : 0;
    } completion:^(BOOL finished) {
        self.imageView.center = self.center;
    }];
}


@end
