//
//  SLLiveFinishView.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/14.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLLiveStartModel.h"
#import "SLLiveListModel.h"
#import "SLFinishModel.h"
@interface SLLiveFinishView : UIView

@property(nonatomic,strong)UIButton * backButton;

-(void)showOnView:(UIView*)view
           reason:(SLLiveFinishType)reason
            model:(SLLiveStartModel*)model;

-(void)showOnView:(UIView*)view
            model:(SLLiveListModel*)model;

-(void)showOnView:(UIView*)view
      finishModel:(SLFinishModel*)finishModel
        liveModel:(SLLiveListModel*)liveModel;


@end
