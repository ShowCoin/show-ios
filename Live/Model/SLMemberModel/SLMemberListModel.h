//
//  SLMemberListModel.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMemberListModel : BaseModel

@property (nonatomic,strong) NSString * uid;
@property (nonatomic,strong) NSString * avatar;
@property (nonatomic,assign) NSInteger  fanLevel;
@property (nonatomic,strong) NSString * nickName;
@property (nonatomic,assign) NSInteger gender;

@end
