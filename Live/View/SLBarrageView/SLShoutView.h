//
//  SLShoutView.h
//  ShowLive
//
//  Created by gongxin on 2018/4/27.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "SLShoutModel.h"

typedef NS_ENUM(NSUInteger, SLShowChannel)
{
    OneChannel = 0,
    TwoChannel = 1,
};//枚举名称

@protocol ShoutViewDelegate <NSObject>

@optional
- (void)animationFinished;
- (void)shoutAnimationFinished:(id)sender;

@end

@interface SLShoutView : UIView

@property (nonatomic, assign) SLShowChannel channelPos;

@property (nonatomic, weak) id<ShoutViewDelegate> delegate;

- (id)initWithModel:(SLShoutModel*)model;

- (void)animationWithDuration:(NSTimeInterval)duraiton;

- (void)setInitialPos:(float)y;
@end
