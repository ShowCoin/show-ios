//
//  SLPushManager.h
//  ShowLive
//
//  Created by gongxin on 2018/4/16.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonInclude.h"
@protocol SLPushManagerProtocol <NSObject>

-(void)pushEvent:(CNC_Ret_Code)code;

@end

@interface SLPushManager : NSObject


@property(nonatomic, weak)id<SLPushManagerProtocol> protocol;

//初始化方法
+ (instancetype)shareInstance;

//网宿推流注册
-(void)register_sdk;

//开启摄像头
-(void)startCarema;

//停止采集
-(void)stopCarema;

//开启预览
-(void)startPreview:(UIView*)view;

//设置配置
-(void)setupConfig:(NSString*)rtmp;

//开始推流
-(void)startPush;

// 停止推流
-(void)stopPush;

// 暂停推流，退到后台时调用
-(void)pause;

// 恢复推流，回到前台时调用
-(void)resume;

//摄像头切换
-(void)switchCamera;

//切换镜像
-(void)switchMirror;

//开启美颜
-(void)startBeautify;

//关闭美颜
-(void)clearBeautify;

//美颜是否开启
-(BOOL)beautifyOpen;


@end
