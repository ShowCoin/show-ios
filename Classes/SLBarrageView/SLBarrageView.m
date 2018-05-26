//
//  SLBarrageView.m
//  ShowLive
//
//  Created by showgx on 2018/4/27.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLBarrageView.h"
@interface SLBarrageView ()<ShoutViewDelegate>
{
    
    
    float baseY;
    //富豪驾到
    BOOL isEmptyRichChannel;
    
    //喊话相关
    BOOL isEmptyShoutChannelOne;
    BOOL isEmptyShoutChannelTwo;
    
    float ShoutChannelOnePosY;
    float ShoutChannelTwoPosY;
    
    float GiftChannelOnePosY;
    float GiftChannelTwoPosY;
    
    CGFloat _mBottomHeight;
    
}
@end

@implementation SLBarrageView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
      
        _shoutQueue            = [[NSMutableArray alloc] init];
        
        //基础高度(中心位置）
        baseY = self.frame.size.height - 250 - 70 - 20-KTabbarSafeBottomMargin;
        
        isEmptyShoutChannelOne = YES;
        isEmptyShoutChannelTwo = YES;
        
        isEmptyRichChannel = YES;
        
        ShoutChannelOnePosY = baseY - 35;
        ShoutChannelTwoPosY = ShoutChannelOnePosY - 35;
        
        GiftChannelOnePosY = ShoutChannelTwoPosY - 40;
        GiftChannelTwoPosY = GiftChannelOnePosY  - 50;
    }
    
    return self;
}



- (void)showShout{
    
    if (isEmptyShoutChannelOne) {
        SLShoutView *shoutView = [[SLShoutView  alloc] initWithModel:_shoutQueue[0]];
        
        shoutView.channelPos = OneChannel;
        
        if ([UIScreen mainScreen].bounds.size.height < 667) {
            
            [shoutView setInitialPos:ShoutChannelOnePosY + 40];
        }else
        {
            [shoutView setInitialPos:ShoutChannelOnePosY];
        }
        
        shoutView.delegate = self;
        [self addSubview:shoutView];
        [shoutView animationWithDuration:5];
        
        isEmptyShoutChannelOne = NO;
        
        [self removeShoutFromQueue];//移除当前数据
    }
    else if(isEmptyShoutChannelTwo && (_shoutQueue.count > 0))
    {
        SLShoutView  *shoutView = [[SLShoutView  alloc] initWithModel:_shoutQueue[0]];
        shoutView.channelPos = TwoChannel;
        
        if ([UIScreen mainScreen].bounds.size.height < 667) {
            
            [shoutView setInitialPos:ShoutChannelTwoPosY  + 50];
        }else
        {
            [shoutView setInitialPos:ShoutChannelTwoPosY];
        }
        
        shoutView.delegate = self;
        [self addSubview:shoutView];
        [shoutView animationWithDuration:5];
        
        isEmptyShoutChannelTwo = NO;
        
        [self removeShoutFromQueue];//移除当前数据
        
    }
    
}

#pragma -mark- 添加删除model


- (void)addShout2QueueWithModel:(SLShoutModel*)model
{
    [_shoutQueue addObject:model];
}


- (void)removeShoutFromQueue
{
    [_shoutQueue removeObjectAtIndex:0];
}

#pragma -mark- 推动View
- (void)pushToUp
{
    //把屏幕推上去
    [UIView animateWithDuration:0.2 animations:^{
        self.origin = CGPointMake(0,  -200);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)pushToOrigin
{
    [UIView animateWithDuration:0.2 animations:^{
        self.origin = CGPointMake(0,0);
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma -mark- Delegate



- (void)shoutAnimationFinished:(SLShoutView*)sender
{
    switch (sender.channelPos) {
        case OneChannel:
        {
            isEmptyShoutChannelOne = YES;
            
            break;
        }
            
        case TwoChannel:
        {
            isEmptyShoutChannelTwo = YES;
            
            break;
        }
            
        default:
            break;
    }
    
    if (_shoutQueue.count > 0) {
        [self showShout];
    }
    
}


#pragma mark
-(void)showToBottomHeight:(CGFloat)bottomHeight
{

    _mBottomHeight = bottomHeight;
    
    if (bottomHeight>10) {
        _mBottomHeight = 200;
    }
    
    self.mj_y = kScreenHeight-self.height-_mBottomHeight;

}


@end

