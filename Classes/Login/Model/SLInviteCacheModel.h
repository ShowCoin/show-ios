//
//  SLInviteCacheModel.h
//  ShowLive
//
//  Created by chenyh on 2018/9/7.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseModel.h"

@interface SLInviteCacheModel : BaseModel

@property (copy, nonatomic) NSString *nickname;
/// 头像
@property (copy, nonatomic) NSString *avatar;
/// 邀请码
@property (copy, nonatomic) NSString *code;
/// 分成比例
@property (copy, nonatomic) NSString *ratio;
/// 是否存在
@property (nonatomic, assign) BOOL exit;

@end
