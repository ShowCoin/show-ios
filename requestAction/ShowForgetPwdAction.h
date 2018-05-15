//
//  ShowForgetPwdAction.h
//  ShowLive
//
//  Created by Z on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAction.h"

@interface ShowForgetPwdAction : ShowAction
@property (nonatomic,copy)NSString * phoneNumber;
@property (nonatomic,copy)NSString * verify_code;
@property (nonatomic,copy)NSString * pwdNew;
@end
