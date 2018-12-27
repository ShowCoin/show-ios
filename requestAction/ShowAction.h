//
//  ShowAction.h
//  ShowLive
//
//  Created by iori_chou on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowRequest.h"
#import "BaseModel.h"
#import "ShowRequestData.h"

typedef void(^ShowActionFinishedBlock)(id result);
typedef void(^ShowActionFailedBlock)(NSError *error);
typedef void(^ShowActionCancelledBlock)(void);

@interface ShowAction : NSObject
/**
 * 创建并返回一个action
 */
+ (instancetype)action;
/**
 *根据是否传入modelClass来决定返回类型
 */
@property(nonatomic,strong) Class modelClass ;

@property(nonatomic,strong) id model ;

/**
 * 成功回调
 */
@property(nonatomic, copy) ShowActionFinishedBlock finishedBlock;

@end
