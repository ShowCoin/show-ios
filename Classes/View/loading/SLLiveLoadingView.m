//
//  SLLiveLoadingView.m
//  ShowLive
//
//  Created by showgx on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveLoadingView.h"
#import "SLShadowLabel.h"
@interface SLLiveLoadingView ()


@property(nonatomic,strong)SLShadowLabel * infoLabel;

@end

@implementation SLLiveLoadingView


-(void)showLoadingCover:(NSString*)cover
                   text:(NSString*)text
                   view:(UIView*)view
{
  

    [view addSubview:self];
    [view  bringSubviewToFront:self];
    NSURL * url = [NSURL URLWithString:cover];
    [self.coverImageView sd_setImageWithURL:url];
    self.infoLabel.text = text;
    [self.infoLabel sizeToFit];
    self.infoLabel.center = self.center;
    [self addSubview:self.coverImageView];
    [self addSubview:self.infoLabel];
    [self addSubview:self.closeButton];

}

-(void)removeLoading
{
    
   [self removeFromSuperview];
}

-(SLShadowLabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[SLShadowLabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, KScreenHeight/2-18, 100, 36)];
        _infoLabel.textColor = 
    }
    return _infoLabel;
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
