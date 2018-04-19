//
//  HFUTNotificationCenter.m
//  HfutXC
//
//  Created by Flame on 2017/3/2.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "HFUTNotificationCenter.h"

@implementation HFUTNotificationCenter


+ (HFUTNotificationCenter*)notificationWithTitle:(NSString *)title Type:(NotificationType)type {
    HFUTNotificationCenter * notification = [[HFUTNotificationCenter alloc] init];
    [notification configWithTitle:title Type:type];
    notification.preBlock = ^{};
    notification.aftBlock = ^{};
    notification.ClickBlock = ^{};
    return notification;
}

- (void)configWithTitle:(NSString*)title Type:(NotificationType)type {
    _bacgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -36, [UIScreen mainScreen].bounds.size.width, 36 + kNaviBarHeight)];
    _bacgroundView.backgroundColor = [UIColor whiteColor];
    _bacgroundView.layer.shadowColor = [UIColor grayColor].CGColor;
    _bacgroundView.layer.shadowOffset = CGSizeMake(0, 5);
    _bacgroundView.layer.shadowOpacity = 0.3;
    [self.view addSubview:_bacgroundView];
    
    _swipeUpForDestroy = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(eventForSwapGesture:)];
    _swipeUpForDestroy.direction = UISwipeGestureRecognizerDirectionUp;
    [_bacgroundView addGestureRecognizer:_swipeUpForDestroy];
    
    _tapOnceForDestroy = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eventForTapGesture:)];
    _tapOnceForDestroy.numberOfTapsRequired = 1;
    [_bacgroundView addGestureRecognizer:_tapOnceForDestroy];
    
    [_swipeUpForDestroy requireGestureRecognizerToFail:_tapOnceForDestroy];
    //优先监听swip手势
    
    switch (type) {
        case HFUTNotificationSuccess:
            _markView = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 15)];
            break;
        case HFUTNotificationError:
//            _markView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notification_error.png"]];
            break;
        case HFUTNotificationInfo:
//            _markView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notification_info.png"]];
            break;
        default:
            break;
    }
    _markView.text = @"[新消息]";
    _markView.font = [UIFont systemFontOfSize:16];
    _markView.textColor = HexRGBAlpha(0x2da5ff, 1);
    if (type != HFUTNotificationDefault) {
        [_markView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_bacgroundView addSubview:_markView];
        NSLayoutConstraint *markLeft = [NSLayoutConstraint constraintWithItem:_markView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_bacgroundView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_markView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_bacgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:[UIApplication sharedApplication].statusBarFrame.size.height - 2];
        NSArray *markArray = [NSArray arrayWithObjects:centerY, markLeft, nil];
        [_bacgroundView addConstraints:markArray];
    }
    
    _notificationMessage = [[UILabel alloc] init];
    _notificationMessage.text = title;
    _notificationMessage.textAlignment = NSTextAlignmentLeft;
    _notificationMessage.textColor = kthemeBlackColor;
    _notificationMessage.font = [UIFont systemFontOfSize:16];
    [_notificationMessage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bacgroundView addSubview:_notificationMessage];
    NSLayoutConstraint *mesLeft = [NSLayoutConstraint constraintWithItem:_notificationMessage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_markView attribute:NSLayoutAttributeRight multiplier:1.0 constant:15];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_notificationMessage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_bacgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:[UIApplication sharedApplication].statusBarFrame.size.height - 2];
    NSLayoutConstraint  * width = [NSLayoutConstraint constraintWithItem:_notificationMessage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_bacgroundView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-40- _markView.width];
    
    NSArray *array = [NSArray arrayWithObjects:mesLeft, centerY,width, nil];
    [_bacgroundView addConstraints:array];
    
    CASpringAnimation * positionY = [CASpringAnimation animationWithKeyPath:@"position.y"];
    positionY.fromValue = [NSNumber numberWithFloat:-50];
    positionY.mass = 1;
    positionY.damping = 10;
    positionY.stiffness = 100;
    positionY.duration = 2.f;
    [_bacgroundView.layer addAnimation:positionY forKey:@"positon_come"];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self.view removeGestureRecognizer:_swipeUpForDestroy];
        [self.view removeGestureRecognizer:_tapOnceForDestroy];
        [self destroy];
    });
    
}

- (void)show {
    _preBlock();
    _window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    _window.windowLevel = UIWindowLevelStatusBar-1;
    _window.rootViewController = self;
    [_window makeKeyAndVisible];
}

- (void)destroy {
    CASpringAnimation *positionYGo = [CASpringAnimation animationWithKeyPath:@"position.y"];
    positionYGo.byValue = [NSNumber numberWithFloat:-64];
    positionYGo.duration = 1.f;
    [_bacgroundView.layer addAnimation:positionYGo forKey:@"position_go"];
    dispatch_time_t time_duration = dispatch_time(DISPATCH_TIME_NOW, 200ull*NSEC_PER_MSEC);
    dispatch_after(time_duration, dispatch_get_main_queue(), ^{
        _window.hidden = YES;
        _window = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HFUTNotificationDestroySuccess" object:self];
        _aftBlock();
    });
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)eventForTapGesture:(id)sender{
    _ClickBlock();
    [self destroy];
}
-(void)eventForSwapGesture:(id)sender{
    [self destroy];
}
- (void)setPreBlock:(PreBlock)preBlock {
    _preBlock = preBlock;
}

- (void)setAftBlock:(PreBlock)aftBlock {
    _aftBlock = aftBlock;
}

- (void)setClickBlock:(PreBlock)ClickBlock{
    _ClickBlock = ClickBlock;
}
@end
