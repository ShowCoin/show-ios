//
//  SLPopView.h
//  ShowLive
//
//  Created by chenyh on 2018/9/8.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLAlertView : UIView

@property (nonatomic, strong, readonly) UIView *contentView;

+ (instancetype)alertView;

- (void)showView;
- (void)hideViewHandler:(SLSimpleBlock)handler;

@end
