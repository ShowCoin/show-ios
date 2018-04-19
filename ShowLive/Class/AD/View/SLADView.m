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


-(void)setupView{
    
    NSURL * url = [NSURL URLWithString:_admodel.thumbnail];
    UIImage * adImage= __IphoneX__? [UIImage imageNamed:@"login_bg"]: [UIImage imageNamed:@"login_bg"];
    if (_admodel) {
        
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



-(UIImageView *)adImageView{
    if (!_adImageView) {
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithFrame: CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didTapAdImageView)];
        [imageView addGestureRecognizer: singleTap];
        _adImageView = imageView;
    }
    return _adImageView;
}

-(UIButton *)progressButtonView{
    if (!_progressButtonView) {
        UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake([UIScreen mainScreen].bounds.size.width - 70, kMainScreenHeight-55, 50, 30)];
        [button setTitle: @"跳过" forState: UIControlStateNormal];
        [button setTitleColor:kGrayBGColor  forState: UIControlStateNormal];
        
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = Font_Regular(13);
        button.backgroundColor = [UIColor clearColor];
        [button addTarget: self  action: @selector(didClickHideButton) forControlEvents: UIControlEventTouchUpInside];
        
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = Color(@"ffffff").CGColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 6;
        _progressButtonView = button;
    }
    return _progressButtonView;
}

#pragma mark - 消失动画
- (void) didClickHideButton {
    [UIView animateWithDuration: 0.4 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAdViewDisappear object:nil];
        [self.delegate ADViewWillDisappear];
        [self removeFromSuperview];
        
    }];
}

#pragma mark - 图片点击事件
- (void)didTapAdImageView{
    
    [_delegate ADViewWillDisappear];
    
}

#pragma mark - 下载图片
- (void) downloadAdImage {
    if (self.imageURL.length >0) {
        [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[[NSURL alloc] initWithString: self.imageURL]options:SDWebImageDownloaderLowPriority  progress:nil  completed:nil];
    }
}


- (NSString *) imageURL {
    return SysConfig.start_ad_image;
}

- (void)hide  {
    
    [UIView animateWithDuration:0.8 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAdViewDisappear object:nil];
        [self removeFromSuperview];
        [self.delegate ADViewWillDisappear];
        
    }];
}

-(SLHeadPortrait *)iconImageView{
    if (!_iconImageView) {
        SLHeadPortrait *imageView = [[SLHeadPortrait alloc] init];
        imageView.frame = (CGRect){(kScreenWidth - 70)/2.0,190 * HScale,70,70};
        imageView.selfFrame = imageView.frame;
        _iconImageView = imageView;
    }
    return _iconImageView;
}

-(UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.frame = (CGRect){0,285 *HScale ,kScreenWidth,60};
        label.font = Font_Regular(16);
        label.textColor = Color(@"333333");
        label.textAlignment = NSTextAlignmentCenter;
        _descLabel = label;
    }
    return _descLabel;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.frame = (CGRect){0,260 *HScale ,kScreenWidth,60};
        label.font = Font_Regular(17);
        label.textColor = Color(@"333333");
        label.textAlignment = NSTextAlignmentCenter;
        _nameLabel = label;
    }
    return _nameLabel;
}

-(UIImageView *)descImageView{
    if (!_descImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = (CGRect){ (kScreenWidth - 192 ) /2.0,kScreenHeight - 80,192,29};
        imageView.image = [UIImage imageNamed:@"seeu_desc_icon"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _descImageView = imageView;
    }
    return _descImageView;
}

-(void)dealloc{
    NSLog(@"---%s----",__func__);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
