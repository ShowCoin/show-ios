//
//  SLLiveStatusModel.h
//  ShowLive
//
//  Created by gongxin on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface SLLiveStatusModel : BaseModel

@property(nonatomic,copy)NSString * liveId;

@property(nonatomic,copy)NSString * roomId;

@property(nonatomic,assign)NSInteger status;

@property(nonatomic,copy)NSString * share_addr;

@property(nonatomic,assign)NSInteger stream_status;

@property(nonatomic,copy)NSString * rtmp;

@property(nonatomic,assign)NSInteger cdnType;

@property(nonatomic,copy)NSString * streamName;

@property(nonatomic,copy)NSString * duration;
@property(nonatomic,assign)NSInteger receive;
@property(nonatomic,assign)NSInteger viewed;
@property(nonatomic,assign)NSInteger liked;


@end
