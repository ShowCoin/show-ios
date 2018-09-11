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
