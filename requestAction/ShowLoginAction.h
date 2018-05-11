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
@interface ShowLoginAction : ShowAction
#pragma mark - thrid
@property (nonatomic,copy)NSString * third_token;
@property (nonatomic,copy)NSString * third_id;
@property (nonatomic,copy)NSString * third_type;
@property (nonatomic,copy)NSString * third_nickname;
@property (nonatomic,copy)NSString * third_headimage;
@property (nonatomic,copy)NSString * wx_usid;
@property (nonatomic,copy)NSString * third_sex;

#pragma mark - phone
@property (nonatomic,copy)NSString *phone;
#pragma mark - email
@property (nonatomic,copy)NSString *email;

@property (nonatomic,copy)NSString *pwd;

@end
