//
//  SLInviteAlertView.h
//  ShowLive
//
//  Created by chenyh on 2018/8/15.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLInviteAlertView : UIView

+ (void)showAlertMessage:(NSAttributedString *)attr handler:(SLSimpleBlock)handler;

@end
