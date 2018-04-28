//
//  SLLocationManager.h
//  ShowLive
//
//  Created by gongxin on 2018/4/23.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLLocationManager : NSObject


+(instancetype)shareManager;

//开始定位
-(void)startLocation;
-(void)startLocationWithAlert:(BOOL)sender;

// 用户是否开启了定位
- (BOOL)userAuthorized;

//关闭定位
-(void)stopLocation;

//为开启定位或者定位错误
-(void)locationManagerError;

//获取定位信息
-(NSDictionary*)getLocationInfo;

//获取纬度
-(NSString*)getLatitude;

//获取经度
-(NSString*)getLongitude;

- (double)getLatitude_f;

- (double)getLongitude_f;

@end
