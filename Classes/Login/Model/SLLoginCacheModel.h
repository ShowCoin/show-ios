//
//  SLLoginCacheModel.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/20.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLLoginCacheModel : NSObject
@property (copy,nonatomic)NSString *nickname;
@property (copy,nonatomic)NSString *avatar;//头像
@property (copy,nonatomic)NSString *lastLoginType;
@property (copy,nonatomic)NSString *phone;
@property (copy,nonatomic)NSString *password;

@end
