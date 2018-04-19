//
//  SLRefreshHeader.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/18.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLRefreshHeader.h"


@implementation SLRefreshHeader
+(instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    SLRefreshHeader *header = [super headerWithRefreshingBlock:refreshingBlock];
    header.lastUpdatedTimeLabel.hidden = YES;
    //    header.stateLabel.hidden = YES;
    return header;
}

+(instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action{
    SLRefreshHeader *header = [super headerWithRefreshingTarget:target refreshingAction:action];
    header.lastUpdatedTimeLabel.hidden = YES;
    //    header.stateLabel.hidden = YES;
    return header;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    CGFloat arrowCenterY = self.mj_h * 0.3;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    
//    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
    self.stateLabel.mj_y = self.arrowView.bottom - 2;
    self.stateLabel.mj_h = self.mj_h - self.stateLabel.mj_y;
//        self.stateLabel.mj_y = arrowCenterY;
    
    self.arrowView.tintColor = self.stateLabel.textColor;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
