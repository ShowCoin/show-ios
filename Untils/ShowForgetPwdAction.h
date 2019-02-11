//
//  ShowForgetPwdAction.h
//  ShowLive
//
//  Created by Z on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAction.h"
//忘记密码
@interface ShowForgetPwdAction : ShowAction
//手机号
@property (nonatomic,copy)NSString * phoneNumber;
//验证吗
@property (nonatomic,copy)NSString * verify_code;
//新密码
@property (nonatomic,copy)NSString * pwdNew;

@end
