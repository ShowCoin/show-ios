//
//  SLGiftListManager.m
//  ShowLive
//
//  Created by gongxin on 2018/4/17.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLGiftListManager.h"
#import "SLGiftListModel.h"
#import "SLGiftAction.h"
#import "SLSendGiftAction.h"
static SLGiftListManager *instance = nil;

@interface SLGiftListManager ()


@end

@implementation SLGiftListManager

/**
 单例
 
 @return 返回实例
 */
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[SLGiftListManager alloc]init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        [self initData];
    }
    
    return self;
}

-(void)initData
{
    
}

/**
 请求礼物列表
 */
- (void)requestGiftListSuccess:(void(^)(NSMutableArray *giftList))success
{
    SLGiftAction * action = [SLGiftAction action];
    
    @weakify(self);
    [self sl_startRequestAction:action Sucess:^(id result) {
        @strongify(self);
        NSArray * giftArray = [result valueForKey:@"gift_list"];
        self.giftList = [SLGiftListModel mj_objectArrayWithKeyValuesArray:giftArray];
         success(self.giftList);
        
    } FaildBlock:^(NSError *error) {
        
        
    }];
}

-(void)sendGift:(SLGiftListModel *)giftModel
      liveModel:(SLLiveListModel*)liveModel
        success:(void (^)(id obj))success
          faile:(void (^)(NSError*))faile

{

    SLSendGiftAction * action = [SLSendGiftAction action];
    action.roomId = liveModel.room_id;
    action.tid    = liveModel.master.uid;
    action.gid    = [NSString stringWithFormat:@"%ld",(long)giftModel.id];
    action.count  = [NSString stringWithFormat:@"%ld",(long)giftModel.doubleHit];
    action.number = @"1";

    [self sl_startRequestAction:action Sucess:^(id result) {
      
        if (success) {
            success(result);
        }
        
    } FaildBlock:^(NSError *error) {
       
        if (faile) {
            faile(error);
        }
        
    }];
    
}

@end
