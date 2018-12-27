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
/**
 * 失败回调
 */
@property(nonatomic, copy) ShowActionFailedBlock failedBlock;
/**
 * 取消回调
 */
@property(nonatomic, copy) ShowActionCancelledBlock cancelledBlock;

/**
 * 开始
 * @note 子类复写
 */
- (void)start;
/**
 * 取消
 * @note 子类复写
 */
- (void)cancel;

//+(void)request

#pragma mark - 子类使用，返回结果
/**
 请求参数在子类中重写
 
 @return 请求参数
 */
- (ShowRequestData *)requestData;

@end
