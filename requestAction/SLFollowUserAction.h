//
//  SLFollowUsersAction.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAction.h"
typedef enum : NSUInteger {
    FollowTypeAdd=1,  //  关注
    FollowTypeDelete,   // 取消关注
} FollowType;

@interface SLFollowUserAction : ShowAction
@property (nonatomic, assign) FollowType type;
@property (nonatomic, strong) NSString *to_uid;

@end
