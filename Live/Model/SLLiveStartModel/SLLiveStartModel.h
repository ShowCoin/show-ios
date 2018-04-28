//
//  SLLiveStartModel.h
//  ShowLive
//
//  Created by gongxin on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface SLLiveStartModel : BaseModel

@property(nonatomic,copy)NSString * rtmp;

@property(nonatomic,assign)NSInteger cdnType;

@property(nonatomic,copy)NSString * share_addr;

@property(nonatomic,copy)NSString * liveId;

@property(nonatomic,copy)NSString * streamName;

@property(nonatomic,copy)NSString * roomId;


@end
