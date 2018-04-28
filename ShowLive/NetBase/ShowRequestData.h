//
//  ShowRequestData.h
//  ShowLive
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowRequestData : NSObject
/**
 * 接口名字
 */
@property(nonatomic, strong) NSString *interface;

/**
 * GET参数
 */
@property(nonatomic, strong, readonly) NSMutableDictionary *querys;

/**
 * POST BODY
 */
@property(nonatomic, strong, readonly) NSMutableDictionary *parameters;

- (void)appendPostDictionary:(NSDictionary *)dic;
- (void)appendPostValue:(id)value key:(NSString *)key;
@end
