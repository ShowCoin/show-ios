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
/**
 请求的接口名需要在子类中重写

 @return 接口名
 */
- (NSString *)interface;

/**
 数据解析，如果子类需要特殊的处理返回数据的话请重写这个方法
 
 @param respDic 返回的数据字典
 */
- (void)parseModel:(NSDictionary *)respDic;
/**
 抛出返回值
 
 @param result 返回值
 */
- (void)throwResult:(id)result;
/**
 抛出错误
 
 @param error 返回的错误
 */
- (void)throwError:(NSError *)error;
/**
 操作取消
 */
- (void)throwCancel;

/**
 请求，对原来的请求的封住，可以用原来的方式进行请求，也可以用这种简便的方式进行
 
 @param sucess 请求成功
 @param faild 请求失败
 */
- (void)startRequestSucess:(ShowActionFinishedBlock)sucess FaildBlock:(ShowActionFailedBlock)faild;
/**
 请求，对原来的请求的封住，可以用原来的方式进行请求，也可以用这种简便的方式进行
 
 @param sucess 请求成功
 @param faild 请求失败
 @param cancelled 请求终止
 */
- (void)startRequestSucess:(ShowActionFinishedBlock)sucess FaildBlock:(ShowActionFailedBlock)faild cancellBlock:(ShowActionCancelledBlock)cancelled;
@end
