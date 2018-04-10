//
//  ShowService.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShowRequest;
@interface ShowService : NSObject

+(void)startRequest:(ShowRequest *)request;
+(void)cancelRequest:(ShowRequest *)request;
+(void)cancelRequestWithId:(NSString *)requestID;

+(void)cleanAllCookie;

@end
