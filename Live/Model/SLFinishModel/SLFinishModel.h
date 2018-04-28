//
//  SLFinishModel.h
//  ShowLive
//
//  Created by gongxin on 2018/4/20.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseModel.h"

@interface SLFinishModel : BaseModel

@property(nonatomic,copy)NSString * duration;
@property(nonatomic,assign)NSInteger liked;
@property(nonatomic,assign)NSInteger receive;
@property(nonatomic,assign)NSInteger viewed;
@property(nonatomic,copy)NSString * uid;


@end
