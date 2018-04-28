//
//  SLLivePreView.h
//  ShowLive
//
//  Created by gongxin on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLLiveStartModel.h"
@protocol SLLivePreViewDelete <NSObject>
@optional

-(void)startLive:(NSString*)theme;

-(void)startLiveSussces:(SLLiveStartModel*)model;

-(void)closeLive;


@end
@interface SLLivePreView : UIView

@property(nonatomic, weak)id<SLLivePreViewDelete> delegate;

-(void)bringContainerViewToFront;

@end
