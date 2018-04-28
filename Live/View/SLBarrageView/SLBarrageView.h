//
//  SLBarrageView.h
//  ShowLive
//
//  Created by gongxin on 2018/4/27.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLShoutView.h"
#import "SLShoutModel.h"
@interface SLBarrageView : UIView

@property (nonatomic, strong) NSMutableArray<SLShoutModel*> *shoutQueue;


- (void)addShout2QueueWithModel:(SLShoutModel*)model;
- (void)showShout;

-(void)showToBottomHeight:(CGFloat)bottomHeight;

@end
