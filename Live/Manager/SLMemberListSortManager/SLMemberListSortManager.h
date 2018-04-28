//
//  SLMemberListSortManager.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLMemberListModel.h"
@interface SLMemberListSortManager : NSObject

//初始化
+(instancetype)shareManager;

//刷新成员列表
@property (nonatomic,copy) void (^reloadMemberView)(NSArray*memberArray);


//获取直播间成员列表
-(void)requestMemberListWithLiveId:(NSString*)liveid;

//成员进入
-(void)joinChatRoomWithMember:(SLMemberListModel*)member;

//成员离开
-(void)exitChatRoomWithMember:(SLMemberListModel*)member;

//成员升级
-(void)upgradeWithMember:(SLMemberListModel*)member;


//直播间成员列表清场
-(void)clearData;
@end
