//
//  SLSystemAlert.h
//  test
//
//  Created by 陈英豪 on 2018/5/21.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLSystemAlertView : UIView

+ (instancetype)createAlert:(NSString *)msg;
- (void)show;

@end
