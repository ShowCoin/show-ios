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

-(void)setupView{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActiveNotification:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActiveNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];

    NSURL * url = [NSURL URLWithString:_admodel.thumbnail];
    UIImage * adImage= __IphoneX__? [UIImage imageNamed:@"login_bg"]: [UIImage imageNamed:@"login_bg"];
    if (_movieURL) {
//        CALayer *backLayer = [CALayer layer];
//        backLayer.frame = [UIScreen mainScreen].bounds;
//        backLayer.contents = (__bridge id _Nullable)(adImage.CGImage);//[UIImage getLaunchImage]
//        [self.layer addSublayer:backLayer];
        self.backgroundColor =kBlackThemeBGColor;
//        [self addSubview:self.moviePlayer.view];
//        [self.moviePlayer play];

        AVPlayer *player = [[AVPlayer alloc] initWithURL:_movieURL];
        self.player = player;
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        self.playerLayer = playerLayer;
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        playerLayer.frame = [UIScreen mainScreen].bounds;
        [self.layer addSublayer:playerLayer];
        [self.player play];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

    }
    
   else if (_admodel) {
        
        [self addSubview:self.adImageView];
        [self addSubview:self.progressButtonView];
        self.progressButtonView.hidden = YES;
        //        UIImage * adImage= __IphoneX__? [UIImage imageNamed:@"adimage_iphoneX"]: [UIImage imageNamed:@"adimage"];
        __weak typeof(self) weaks = self;
        [self.adImageView yy_setImageWithURL:url placeholder:adImage options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            weaks.progressButtonView.hidden = NO;
        }];
    }else{
        [self addSubview:self.adImageView];
        self.adImageView.image = adImage;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.descLabel];
        
        UIImage *image = [[YYWebImageManager sharedManager].cache getImageForKey:AccountUserInfoModel.avatar];
        if (image == nil && AccountUserInfoModel.avatar.length >0) {
            [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:AccountUserInfoModel.avatar] options:0 progress:nil transform:nil completion:nil];
        }
        image = image == nil? [UIImage imageNamed:@"userhome_admin_Img"] : image;
        if (image) {
            [self.iconImageView setRoundStyle:YES imageUrl:@"" imageHeight:90 vip:NO attestation:NO];
            self.iconImageView.imageView.image = image;
        }
        
        self.nameLabel.text = [NSString stringWithFormat:@"Hi %@",AccountUserInfoModel.nickname?AccountUserInfoModel.nickname:@"老铁"];
        self.descLabel.text =  @"欢迎回来";
        
        self.iconImageView.alpha = 0;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.iconImageView.transform = CGAffineTransformMakeTranslation(0, -20 *HScale);
            self.iconImageView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        
        self.nameLabel.alpha = 0;
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.nameLabel.transform = CGAffineTransformMakeTranslation(0, -20 *HScale);
            self.nameLabel.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        
        self.descLabel.alpha = 0;
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.descLabel.transform = CGAffineTransformMakeTranslation(0, -20 *HScale);
            self.descLabel.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
