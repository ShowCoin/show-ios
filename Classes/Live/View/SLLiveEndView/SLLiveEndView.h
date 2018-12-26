//
//  SLLiveEndView.h
//  ShowLive
//
//  Created by gongxin on 2018/9/28.
//  Copyright © 2018 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLLiveEvaFooterView.h"
#import "SLLiveStopModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ShareBlock)(void);

@interface SLLiveEndView : UIImageView

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) SLLiveEvaFooterView *footer;

@property (copy, nonatomic) ShareBlock shareBlock;

//主播直播结束
-(void)showOnView:(UIView*)view
           reason:(SLLiveFinishType)reason
            model:(SLLiveStartModel*)model;

//看播直播结束
-(void)finishLive:(SLLiveStopModel*)model
       masterData:(SLLiveListModel*)data
        superView:(UIView*)view;

@end

NS_ASSUME_NONNULL_END
