//
//  SLGooglePassWordAlert.h
//  ShowLive
//
//  Created by vning on 2018/7/27.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLGooglePassWordAlert;

@protocol SLGooglePassWordAlertDelegate <NSObject>

/**
 确定按钮的执行方法
 */
- (void)sureActionWithAlertGooglePasswordView:(SLGooglePassWordAlert *)alertPasswordView password:(NSString *)password;

@end
@interface SLGooglePassWordAlert : UIView
@property (nonatomic, assign) id<SLGooglePassWordAlertDelegate> delegate;

@end
