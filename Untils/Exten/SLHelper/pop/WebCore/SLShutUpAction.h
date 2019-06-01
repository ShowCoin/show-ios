//
//  SLShutUpAction.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/17.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAction.h"

@interface SLShutUpAction : ShowAction

//用户uid
@property (nonatomic,copy) NSString * uid;
//房间id
@property (nonatomic,copy) NSString * roomId;
//时间
@property (nonatomic,copy) NSString * minute;

@end
