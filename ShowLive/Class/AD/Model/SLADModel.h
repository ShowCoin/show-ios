//
//  SLADView.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/17.
//  Copyright © 2018年 vning. All rights reserved.
//
/**
 |===    跳转类型说明表   ===|
 -------------------------------------------------------------------------------------------------
 | redirect_type    | 跳转                | 参数及说明
 0                 常规h5                url：h5网址
 1                 聊天窗口页              redirect_id：代表targetId，聊天对方的id
 2                 官方聊天窗口页           无，跳固定的消息窗口
 3                 个人页                 redirect_id：代表userid
 ------------------------------------------------------------------------------------------------
 */
#import <Foundation/Foundation.h>

@interface SLADModel : NSObject
@property (nonatomic,strong)NSString * id;
@property (nonatomic,copy)NSString * redirect_id;
@property (nonatomic,copy)NSString * redirect_type;
@property (nonatomic,copy)NSString * thumbnail;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * topic_type;
@property (nonatomic,copy)NSString * url;
-(void)saveWithDictionary:(NSDictionary *)ConfigDict;

@end
