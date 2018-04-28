//
//  SLGiftListModel.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "BaseModel.h"

@interface SLGiftListModel : BaseModel

@property(nonatomic,assign)NSInteger exp; //经验

@property(nonatomic,copy)NSString * icon; //图标

@property(nonatomic,assign)NSInteger id; //礼物id

@property(nonatomic,copy)NSString * image;//图片地址

@property(nonatomic,copy)NSString * name; //礼物名称

@property(nonatomic,assign)NSInteger price; //价格

@property(nonatomic,assign)NSInteger type;//类型


/**
 zip地址
 */
@property (nonatomic, copy) NSString *zipUrl;


/**
 礼物唯一标识
 */
@property (nonatomic, copy) NSString *giftUniTag;

/**
 连击数
 */
@property (nonatomic,assign) NSInteger doubleHit;


- (void)analysisGiftInfowithModel:(SLGiftListModel *)model;

@end
