//
//  KMencryption.h
//  ShowLive
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowShortVideoPlayer : NSObject

/**
 *  请求头 已经包含请求参数 加秘钥串
 */
+(NSDictionary *)cryptDict:(NSDictionary *)cryptData parameters:(NSDictionary *)parameters;

@end
