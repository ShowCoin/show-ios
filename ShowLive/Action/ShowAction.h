//
//  ShowAction.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowRequest.h"
typedef void(^ShowActionFinishedBlock)(id result);
typedef void(^ShowActionFailedBlock)(NSError *error);
typedef void(^ShowActionCancelledBlock)(void);

@interface ShowAction : NSObject
/**
 * 创建并返回一个action
 */
+ (instancetype)action;
/**
 * 成功回调
 */
@property(nonatomic, strong) ShowActionFinishedBlock finishedBlock;
/**
 * 失败回调
 */
@property(nonatomic, strong) ShowActionFailedBlock failedBlock;
/**
 * 取消回调
 */
@property(nonatomic, strong) ShowActionCancelledBlock cancelledBlock;

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

#pragma mark - 子类使用，返回结果
- (void)throwResult:(id)result;
- (void)throwError:(NSError *)error;
- (void)throwCancel;
@end
