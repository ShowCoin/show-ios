//
//  ShowLoginAction.h
//  ShowLive
//
//  Created by iori_chou on 2018/3/28.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAction.h"
#import "ShowRequest.h"
#import "AccountModel.h"
//登录接口
@interface ShowLoginAction : ShowAction
#pragma mark - thrid
//第三方token
@property (nonatomic,copy)NSString * third_token;
//第三房ID
@property (nonatomic,copy)NSString * third_id;
//第三方类型
@property (nonatomic,copy)NSString * third_type;
//第三方名称
@property (nonatomic,copy)NSString * third_nickname;
//第三方头像
@property (nonatomic,copy)NSString * third_headimage;
//第三方头像
@property (nonatomic,copy)NSString * wx_usid;
//第三方数据饿性别
@property (nonatomic,copy)NSString * third_sex;

#pragma mark - phone
//手机号
@property (nonatomic,copy)NSString *phone;
#pragma mark - email
//邮件
@property (nonatomic,copy)NSString *email;
//密码的设置
@property (nonatomic,copy)NSString *pwd;

@end
