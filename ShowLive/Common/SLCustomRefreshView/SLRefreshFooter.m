//
//  SLRefreshFooter.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/18.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLRefreshFooter.h"

@implementation SLRefreshFooter

+(instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    SLRefreshFooter *footer = [super footerWithRefreshingBlock:refreshingBlock];
    footer.stateLabel.hidden = YES;
    return footer;
}

+(instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action{
    SLRefreshFooter *footer = [super footerWithRefreshingTarget:target refreshingAction:action];
    footer.stateLabel.hidden = YES;
    return footer;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.loadingView.constraints.count) return;
    
    // 圈圈
    CGFloat loadingCenterX = self.mj_w * 0.5;
    CGFloat loadingCenterY = self.mj_h * 0.5;
    self.loadingView.center = CGPointMake(loadingCenterX, loadingCenterY);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
