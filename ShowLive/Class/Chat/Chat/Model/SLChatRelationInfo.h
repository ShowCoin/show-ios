//
//  SLChatRelationInfo.h
//  ShowLive
//
//  Created by Mac on 2018/4/14.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, SLChatRelationType) {
    SLChatRelationTypeFollowNone  = 0,
    SLChatRelationTypeFollowHim  = 1,
    SLChatRelationTypeFollowMe   = 2,
    SLChatRelationTypeFollowBoth = 3
};
@interface SLChatRelationInfo : NSObject
/**
 *  0：互相均未关注，1：已关注对方，2：对方已关注自己，3：互为好友
 */
@property (nonatomic, assign) SLChatRelationType relation;
/**
 *  1男
 */
@property (nonatomic, assign) NSInteger gender;
/**
 *  距离，eg: "0.1SL"
 */
@property (nonatomic, copy) NSString *distance;
/**
 *  用户的离线时间,eg:"07-24 20:41"
 */
@property (nonatomic, copy) NSString *diffTime;
/**
 *  魅力值
 */
@property (nonatomic, assign) NSInteger charm;
/**
 *  当前礼品有效截止时间 ，-1代表永久有效
 */
@property (nonatomic, assign) NSTimeInterval deadTime;
/**
 *  用户最后一次登录时间
 */
@property (nonatomic, assign) NSTimeInterval lastLoginTime;
/**
 *  当前可赠送的礼物id
 */
@property (nonatomic, assign) NSInteger giftId;
/**
 *  最近送礼时间
 */
@property (nonatomic, strong) NSArray *lastTimes;
/**
 *  礼物金额,如果是0，说明是免费礼物
 */
@property (nonatomic, assign) int giftPrice;

/**
 vip才有的功能
 1：隐身，0：不隐身
 */
@property (assign, nonatomic) NSInteger isVipHide;

/**
 是否vip
 */
@property (strong, nonatomic) NSString *isVip;


/**
 城市
 */
@property (strong, nonatomic) NSString *city;
@end
