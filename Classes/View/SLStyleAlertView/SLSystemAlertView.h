//
//  SLSystemAlert.h
//  test
//
//  Created by 陈英豪 on 2018/5/21.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLSystemAlertView : UIView

/**
 show alert view on window

 @param msg info
 @return instance
 */
+ (instancetype)createAlert:(NSString *)msg;

/**
 only need show view, and auto remove from superview
 */
- (void)show;

@end
