//
//  SLLiveLoadingView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveLoadingView.h"

@interface SLLiveLoadingView ()


@property(nonatomic,strong)UIActivityIndicatorView * activityIndicator;

@property(nonatomic,strong)UILabel * infoLabel;

@end

@implementation SLLiveLoadingView


-(void)showLoadingCover:(NSString*)cover
                   text:(NSString*)text
                   view:(UIView*)view
{
   
    [view addSubview:self];
    NSURL * url = [NSURL URLWithString:cover];
    [self.coverImageView sd_setImageWithURL:url];
    self.infoLabel.text = IsStrEmpty(text)?@"加载中...":text;
    [self.infoLabel sizeToFit];
    self.infoLabel.center = self.center;
    self.activityIndicator.mj_x = kScreenWidth/2- self.infoLabel.width/2 - 46;
    
    [self addSubview:self.coverImageView];
    [self addSubview:self.activityIndicator];
    [self addSubview:self.infoLabel];
    [self addSubview:self.closeButton];


}


-(void)removeLoading
{
   [self removeFromSuperview];
}

-(UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, KScreenHeight/2-18, 100, 36)];
        _infoLabel.layer.shadowRadius = 4.0f;
        _infoLabel.layer.shadowOpacity = 0.5;
        _infoLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        _infoLabel.layer.shadowOffset = CGSizeMake(2, 2);
        _infoLabel.layer.masksToBounds = NO;
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.font = [UIFont systemFontOfSize:20];
    }
    return _infoLabel;
}

-(UIActivityIndicatorView*)activityIndicator
{
 
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        _activityIndicator.frame= CGRectMake(KScreenWidth/2-46,KScreenHeight/2-18,36,36);
        _activityIndicator.color = [UIColor whiteColor];
        _activityIndicator.backgroundColor = [UIColor clearColor];
        _activityIndicator.hidesWhenStopped = NO;
        [_activityIndicator startAnimating];
    }
    return _activityIndicator;
}
  

-(UIImageView*)coverImageView
{
    if (!_coverImageView) {
        _coverImageView=[[UIImageView alloc]initWithFrame:self.bounds];
        _coverImageView.userInteractionEnabled=YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _coverImageView;
}

-(UIButton*)closeButton
{
    if (!_closeButton) {
        CGFloat closeButtonWidth =40;
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(self.frame.size.width - 10.f - closeButtonWidth,23+KNaviBarSafeBottomMargin, closeButtonWidth, closeButtonWidth);
        _closeButton.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.f];
        [_closeButton setImage:[UIImage imageNamed:@"live_close_button"] forState:UIControlStateNormal];
       
    }
    return _closeButton;
}

@end
