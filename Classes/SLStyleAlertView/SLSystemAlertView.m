//
//  SLSystemAlert.m
//  test
//
//  Created by 陈英豪 on 2018/5/21.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLSystemAlertView.h"

/**
 define color

 @param rgbValue red green blue
 @param a create 0xColor
 @return UIColor
 */
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

/**
 General Gray

 @param 0x999999 vaule
 @param 1 Gray
 @return Gray Color
 */
#define kGrayWith999999         HexRGBAlpha(0x999999, 1)

@interface SLSystemAlertView ()

@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *button;

@end

@implementation SLSystemAlertView

+ (instancetype)createAlert:(NSString *)msg {
    SLSystemAlertView *view = [[SLSystemAlertView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.message = msg;
    view.alpha = 0;
    [UIApplication.sharedApplication.windows.firstObject addSubview:view];
    return view;
}


- (void)setMessage:(NSString *)message {
    _message = message;
    self.messageLabel.text = message;
    [self setNeedsLayout];
}

- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self hidden];
//}

- (void)buttonAction {
    [self hidden];
}

- (void)hidden {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
