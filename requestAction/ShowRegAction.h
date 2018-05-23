//
//  ShowRegAction.h
//  ShowLive
//
//  Created by iori_chou on 2018/3/28.
//  Copyright © 2018年 vilige. All rights reserved.
//

#import "ShowAction.h"
#import "ShowRequest.h"
#import "AccountModel.h"

@interface ShowRegAction : ShowAction

#pragma mark - phone
//手机号
@property (nonatomic,copy)NSString *phone;
#pragma mark - email
//邮件
@property (nonatomic,copy)NSString *email;

@property (nonatomic,copy)NSString *pwd;

@end
