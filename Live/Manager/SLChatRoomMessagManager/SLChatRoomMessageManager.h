//
//  SLChatRoomMessageManager.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/18.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLReceivedGiftModel.h"
#import "SLFinishModel.h"
#import "SLShoutModel.h"
@protocol SLChatRoomMessageDelegate <NSObject>


@required // 必须实现的方法

-(void)updateMemberList:(NSArray*)memberList
                  total:(NSString*)total;
-(void)receiveGift:(SLReceivedGiftModel*)giftModel;
-(void)showShout:(SLShoutModel*)model;

@optional // 可选实现的方法

-(void)notice:(NSString*)content;
-(void)anchorOut; //主播切出
-(void)anchorBack; //主播切回
-(void)finishLive:(SLFinishModel*)finishModel;


@end
@interface SLChatRoomMessageManager : NSObject

@property (nonatomic, weak) id<SLChatRoomMessageDelegate>delegate;

+(instancetype)shareInstance;

@property(nonatomic,copy)NSString * roomId;

-(void)addChatRoomMessageNotification;

-(void)removeChatRoomMessageNotification;



@end
