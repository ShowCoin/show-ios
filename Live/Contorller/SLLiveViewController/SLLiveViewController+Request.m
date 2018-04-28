//
//  SLLiveViewController+Request.m
//  ShowLive
//
//  Created by gongxin on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveViewController+Request.h"
#import "SLLiveOpenAction.h"

@implementation SLLiveViewController (Request)

-(void)liveOpen:(NSString*)streamName
        success:(void (^)(id obj))success
          faile:(void (^)(NSError*))faile
{
    SLLiveOpenAction * action = [SLLiveOpenAction action];
    action.streamName = streamName;

 
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
