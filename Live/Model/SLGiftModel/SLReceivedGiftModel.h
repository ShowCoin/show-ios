//
//  SLReceivedGiftModel.h
//  ShowLive
//
//  Created by gongxin on 2018/4/17.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(long, SLAnimatingType) {
    SLAnimatingTypeDoubleHit = 1,
    SLAnimatingTypeDynamic = 2,
    SLAnimatingTypeFaceU = 3,
  
};

@interface SLReceivedGiftModel : BaseModel

//商品ID
@property (nonatomic, copy) NSString *goods_id;

//商品名称
@property (nonatomic, copy) NSString *goods_name;

//商品图片
@property (nonatomic, copy) NSString *goods_pic;

//用户ID
@property (nonatomic, copy) NSString *user_id;

//用户昵称
@property (nonatomic, copy) NSString *nickname;

//用户头像
@property (nonatomic, copy) NSString *head_photo;

//用户等级
@property (nonatomic, assign) NSInteger level;



@property (nonatomic, assign)SLAnimatingType animating_type;

//连击
@property (atomic, assign) NSInteger double_hit;

// 礼物显示位置 0-显示在屏幕中央 1-显示在屏幕底部 2-显示在屏幕顶部 3-全屏显示
@property (nonatomic, assign) int position;

// 大礼物播放次数
@property (nonatomic, assign) int play_frequency;

// 礼物共有多少帧
@property (nonatomic, assign) int total_frames;

/**
 连击礼物的唯一标志
 */
@property (nonatomic, copy) NSString *giftUniTag;

/**
 礼物数量
 */
@property (atomic, assign) NSInteger num;

/**
 礼物单价
 */
@property (nonatomic,assign) NSInteger price;

/**
 送出礼物的总价值
 */
@property (nonatomic,assign) NSInteger totlePrice;

//小礼物通道
@property (nonatomic,assign) int channel;


@end
