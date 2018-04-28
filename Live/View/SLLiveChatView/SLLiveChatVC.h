//
//  SLLiveChatVC.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/19.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseTableVC.h"

@interface SLLiveChatVC : BaseTableVC

+ (instancetype)showInView:(UIViewController *)fatherView ;

+ (instancetype )showInView:(UIViewController *)fatherVC model:(ShowUserModel *)masterModel;

- (void)hideWithAnimation:(BOOL)animation;

- (void)show;

@end
