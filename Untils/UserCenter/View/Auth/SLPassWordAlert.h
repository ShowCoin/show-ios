//
//  SLPassWordAlert.h
//  ShowLive
//
//  Created by vning on 2018/7/27.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLPassWordAlert;

@protocol SLPassWordAlertDelegate <NSObject>

/**
 确定按钮的执行方法
 */
- (void)sureActionWithAlertPasswordView:(SLPassWordAlert *)alertPasswordView password:(NSString *)password;
@end

@interface SLPassWordAlert : UIView

@property (nonatomic, assign) id<SLPassWordAlertDelegate> delegate;
@property (nonatomic, strong) UILabel * cointypeLab;
@property (nonatomic, strong) UILabel * coinNumLab;
@property (nonatomic, strong) UILabel * coinRMBLab;

@end
