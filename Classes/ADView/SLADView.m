//
//  SLADView.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/17.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLADView.h"
#import "DACircularProgressView.h"
#import "UIImageView+WebCache.h"
#import "SLHeadPortrait.h"
#import "SLADModel.h"
#import "SLPlayerManager.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImage+LaunchImage.h"

@interface AnimationDelegate : NSObject  <CAAnimationDelegate>

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation AnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.player play];
}

@end

@interface SLADView ()

@property (nonatomic, strong) UIView *adBackground;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) YYAnimatedImageView *adImageView;
@property (nonatomic, strong) DACircularProgressView *progressView;
@property (nonatomic, strong) UIButton *progressButtonView;

@property (nonatomic, strong) SLHeadPortrait *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *descImageView;

@property (nonatomic, strong) SLADModel *admodel;

@property (nonatomic, weak) AVPlayer *player;
@property (nonatomic, weak) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) CABasicAnimation *scaleAnimation;
@property (nonatomic, strong) MPMoviePlayerController * moviePlayer;
@end

@implementation SLADView
#pragma mark - override
- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //        [self downloadAdImage];
        [self setupView];
    
        __weak typeof(self) weaks = self;
        dispatch_time_t show = dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC);
        dispatch_after(show, dispatch_get_main_queue(), ^(void){
            [weaks hide];
        });
    }
    return self;
}
- (instancetype) initWithFrame:(CGRect)frame withMovieUrl:(NSURL *)movieURL{
    if (self = [super initWithFrame:frame]) {
        _movieURL = movieURL;
        //        [self downloadAdImage];
        [self setupView];
        
//        __weak typeof(self) weaks = self;
//        dispatch_time_t show = dispatch_time(DISPATCH_TIME_NOW, 6 * NSEC_PER_SEC);
//        dispatch_after(show, dispatch_get_main_queue(), ^(void){
//            [weaks hide];
//        });
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
