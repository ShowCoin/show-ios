//
//  SLHistoryWorksAction.h
//  ShowLive
//
//  Created by vning on 2018/4/18.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAction.h"

@interface SLHistoryWorksAction : ShowAction
//记录起始位置,非必需,默认值为0
@property (nonatomic, copy) NSString *cursor;
//记录数量,非必需,默认值为20
@property (nonatomic, copy) NSString *count;
//用户id
@property (nonatomic, copy) NSString *uid;

@end
