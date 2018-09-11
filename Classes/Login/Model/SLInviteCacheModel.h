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

/// 更新保存
- (void)sl_update;

/**
 检测invitecode是否可用, 如果可用赋值自己同时回调

 @param code 邀请码
 @param handler 回调
 */
- (void)sl_checkInviteCode:(NSString *)code handler:(SLSimpleBlock)handler;

+ (instancetype)currentCache;

@end
