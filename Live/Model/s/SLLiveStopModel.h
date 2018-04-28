//
//  SLLiveStopModel.h
//  ShowLive
//
//  Created by gongxin on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface SLLiveStopModel : BaseModel

@property(nonatomic,assign)NSInteger liked;
@property(nonatomic,assign)NSInteger receive;
@property(nonatomic,assign)NSInteger viewed;
@property(nonatomic,copy)NSString * duration;

@end
