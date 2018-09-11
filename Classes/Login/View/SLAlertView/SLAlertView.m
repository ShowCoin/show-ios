//
//  SLPopView.m
//  ShowLive
//
//  Created by chenyh on 2018/9/8.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLAlertView.h"

@interface SLAlertView ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation SLAlertView

- (void)dealloc {
    NSLog(@"%s -> %@", __func__, NSStringFromClass([self class]));
}

+ (instancetype)alertView {
    SLAlertView *view = [[self alloc] init];
    view.frame = UIScreen.mainScreen.bounds;
    view.alpha = 0;
    [UIApplication.sharedApplication.keyWindow addSubview:view];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HexRGBAlpha(0x0c0c0c, 0.7);
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)showView {
}

#pragma mark - lazy

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = HexRGBAlpha(0x1e1e1e, 1);
        _contentView.layer.cornerRadius = 6;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

@end
