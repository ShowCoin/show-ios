//
//  SLLiveEndRankView.h
//  ShowLive
//
//  Created by gongxin on 2018/9/28.
//  Copyright © 2018 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLLiveEndRankView : UIView

-(void)setRank:(NSString*)rank
         total:(NSString*)total;

-(void)updateDuan:(NSString*)duan isShared:(BOOL)isShared;

@end

NS_ASSUME_NONNULL_END
