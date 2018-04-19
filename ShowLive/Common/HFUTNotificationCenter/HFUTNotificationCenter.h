//
//  HFUTNotificationCenter.h
//  HfutXC
//
//  Created by Flame on 2017/3/2.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NotificationType) {
    HFUTNotificationDefault,
    HFUTNotificationSuccess,
    HFUTNotificationError,
    HFUTNotificationInfo
};

@interface HFUTNotificationCenter: UIViewController

typedef void (^PreBlock)(void);

+ (HFUTNotificationCenter*)notificationWithTitle:(NSString*)title Type:(NotificationType)type;

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *bacgroundView;
@property (nonatomic, strong) UILabel *markView;
@property (nonatomic, strong) UILabel *notificationMessage;

@property (nonatomic, strong) PreBlock ClickBlock;
@property (nonatomic, strong) PreBlock preBlock;
@property (nonatomic, strong) PreBlock aftBlock;

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeUpForDestroy;
@property (nonatomic, strong) UITapGestureRecognizer *tapOnceForDestroy;

- (void)show;
- (void)destroy;

- (void)setPreBlock:(PreBlock)preBlock;
- (void)setAftBlock:(PreBlock)aftBlock;
- (void)setClickBlock:(PreBlock)ClickBlock;

@end
