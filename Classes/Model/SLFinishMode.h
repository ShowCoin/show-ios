//
//  SLFinishModel.h
//  ShowLive
//
//  Created by show gx on 2018/4/20.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseModel.h"

@interface SLFinishModel : BaseModel

@property(nonatomic,assign)float cny;
@property(nonatomic,copy)NSString * duration;
@property(nonatomic,assign)NSInteger liked;
@property(nonatomic,assign)NSInteger receive;
@property(nonatomic,assign)NSInteger viewed;
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * gradeTitle;
@property(nonatomic,copy)NSString * gradeDuan;
@property(nonatomic,copy)NSString * gradeRank;
@property(nonatomic,copy)NSString *gradeTotal;

@end
