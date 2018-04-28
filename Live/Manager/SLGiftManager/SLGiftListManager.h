//
//  SLGiftListManager.h
//  ShowLive
//
//  Created by gongxin on 2018/4/17.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLGiftListModel.h"
#import "SLLiveListModel.h"
@interface SLGiftListManager : NSObject

//礼物列表
@property (nonatomic, strong)NSMutableArray *giftList;


+(instancetype)shareInstance;


/**
 请求礼物列表
 */
- (void)requestGiftListSuccess:(void(^)(NSMutableArray  *giftList))success;


//发送礼物
-(void)sendGift:(SLGiftListModel *)giftModel
      liveModel:(SLLiveListModel*)liveModel
        success:(void (^)(id obj))success
          faile:(void (^)(NSError*))faile;

@end
