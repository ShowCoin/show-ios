//
//  KMencryption.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KMencryption : NSObject

/**
 *  请求头 已经包含请求参数 加秘钥串
 */
+(NSDictionary *)cryptDict:(NSDictionary *)cryptData parameters:(NSDictionary *)parameters;

@end
