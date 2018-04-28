//
//  SLLiveBottomView.h
//  ShowLive
//
//  Created by gongxin on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SLLiveBottomViewProtocol <NSObject>

@optional

-(void)selectBottomViewAtIndex:(SLBottomButtonClickType)type;

@end

@interface SLLiveBottomView : UIView

@property (nonatomic, weak) id<SLLiveBottomViewProtocol>protocol;

//直播间类型
@property(nonatomic,assign)SLLiveContollerType controllerType;


-(void)setAnchorNickName:(NSString*)nickName
               liveTheme:(NSString*)theme;


@end
