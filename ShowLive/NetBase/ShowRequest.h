//
//  ShowRequest.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowRequestData.h"
@class AFHTTPRequestOperationManager;
@class ShowRequest;

typedef void(^ShowRequestSucceedBlock)(ShowRequest *request, id responseObject);
typedef void(^ShowRequestFailedBlock)(ShowRequest *request, NSError *error);
typedef void(^ShowRequestCancelledBlock)(ShowRequest *request);

@interface ShowRequest : NSObject
@property(nonatomic, strong) NSString *requestID;
@property(nonatomic, strong) NSString *serverURL;
@property(nonatomic, strong) ShowRequestData *requestData;

@property(nonatomic, strong) ShowRequestSucceedBlock successeBlock;
@property(nonatomic, strong) ShowRequestFailedBlock failedBlock;
@property(nonatomic, strong) ShowRequestCancelledBlock cancelledBlock;

@property(nonatomic, assign) NSTimeInterval startTimestamp;
@property(nonatomic, strong) AFHTTPRequestOperationManager *manager;
/**
 * 超时秒数，默认值参见Show_DEFAULT_TIMEOUT_SECONDS
 */
@property(nonatomic, assign) double timeoutSeconds;

/**
 *  post 请求
 */
+ (void)requestWithData:(NSString *)serverUrl
            requestData:(ShowRequestData *)requestData
                succeed:(ShowRequestSucceedBlock)succeedBlock
                 failed:(ShowRequestFailedBlock)failedBlock
              cancelled:(ShowRequestCancelledBlock)cancelledBlock;


- (void)cancel;

@end
