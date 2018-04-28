//
//  SLLiveRightView.h
//  ShowLive
//
//  Created by gongxin on 2018/4/25.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLLiveRightView : UIView

//直播间类型
@property(nonatomic,assign)SLLiveContollerType controllerType;

//头像
-(void)setAvatar:(NSString*)avatar;

//更新观看人数
-(void)updateWatches:(NSString*)watches;

//主播id
-(void)setAnchorId:(NSString*)anchorId;

//秀币
-(void)updateCoin:(NSString*)coin;

//增加秀币
-(void)addCoin:(NSInteger)coin;

//拉取成员列表
-(void)getMemberList:(NSString*)roomId;

//更新成员列表
-(void)updateMemberList:(NSArray*)array;

//看播端
-(void)updateData:(SLLiveListModel *)listModel;

//隐藏
-(void)setRightViewHide:(BOOL)hide;

//隐藏成员列表
-(void)disMissMemberListView;

@end
