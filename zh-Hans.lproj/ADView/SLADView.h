//
//  SLADView.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/17.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SLADViewDelegate <NSObject>

//代理方法，View即将消失
- (void)ADViewWillDisappear;

@end

@interface SLADView : UIView
//SLAD的代理
@property (nonatomic, weak) id<SLADViewDelegate> delegate;
//播放视频的URL
@property (nonatomic,strong) NSURL *movieURL;
//初始化方法
- (instancetype) initWithFrame:(CGRect)frame withMovieUrl:(NSURL *)movieURL;

@end
