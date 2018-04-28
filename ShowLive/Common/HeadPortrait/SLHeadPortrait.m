//
//  SLHeadPortrait.m
//  ShowLive
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLHeadPortrait.h"
#import "NSString+Validation.h"

@implementation SLHeadPortrait
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        vipWidth = self.size.width *0.53;
        vipHeight = self.size.height * 0.42;
        vipLeft  =self.size.width*0.045;
        vipTop  =self.size.width*0.146;
        [self addloadView];
    }
    return self;
}

//重置frame方法
-(void)setSelfFrame:(CGRect)selfFrame
{
    CGRect frame = CGRectMake(selfFrame.origin.x, selfFrame.origin.y, selfFrame.size.width, selfFrame.size.height);
    aFrame = selfFrame;
    _imageView.frame = CGRectMake(0, 0, selfFrame.size.width, selfFrame.size.height);
    self.frame = frame ;
    vipWidth = self.size.width *0.53;
    vipHeight = self.size.height * 0.42;
    vipLeft  =self.size.width*0.045;
    vipTop  =self.size.width*0.146;
    [self addloadView];
}

-(void)addloadView
{
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    aFrame = self.frame;
    
    if (!_imageView) {
        self.imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _imageView.userInteractionEnabled=YES;
        [self addSubview:_imageView];
    }
    //设置图片剧中显示
    [_imageView setImageClipsToBounds];
    
    //添加认证图标
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.image = [UIImage imageNamed:@"认证图标"];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        _imageV.hidden = YES;
        [self addSubview:_imageV];
    }
    if (!_vipIcon) {
        _vipIcon = [[UIImageView alloc]init];
        _vipIcon.image = [UIImage imageNamed:@"vipIcon"];
        _vipIcon.contentMode = UIViewContentModeScaleAspectFit;
        _vipIcon.hidden = YES;
        [self addSubview:_vipIcon];
    }
    self.frame = frame ;
    
    //添加点击方法
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headPortraitClick)]];
}
- (void)setRoundStyle:(BOOL)roundStyle image:(UIImage *)image;
{
    [_imageView setImage:image];
    
    if (roundStyle)
        [_imageView roundStyle];
    else
        [_imageView cornerRadiusStyle];
}


- (void)setRoundStyle:(BOOL)roundStyle imageUrl:(NSString *)imageUrl imageHeight:(float)imageheight vip:(BOOL)vip attestation:(BOOL)attestation{
    
    @weakify_old(self)
    [_imageView yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"userhome_avatar_image"] options:YYWebImageOptionAvoidSetImage completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        @strongify_old(self)
        if (strong_self &&[strong_self isKindOfClass:[SLHeadPortrait class]]&& strong_self.imageView&&image) {
            [strong_self.imageView setImage:image];
        }
    }];
    _vipIcon.hidden=vip?NO:YES;
    _vipIcon.frame = CGRectMake(-vipLeft,-vipTop, vipWidth,vipHeight);
    if (roundStyle)
        [_imageView roundStyle];
    else
        [_imageView cornerRadiusStyle];
    
    if (imageheight==64) {
        [self layerWithView:_imageView withColor:RGBCOLOR(139, 96, 236) width:6];
        //        [_imageView borderStyleWithColor:RGBCOLOR(139, 96, 236)  width:aFrame.size.width * 0.046];
    }
    else if (imageheight==75||imageheight==84) {
        [self layerWithView:_imageView withColor:kThemeWhiteColor width:aFrame.size.width * 0.046];
    }
    else{
        vipLeft  =self.size.width*0.065;
        vipTop  =self.size.width*0.196;
        _vipIcon.frame = CGRectMake(-vipLeft,-vipTop, vipWidth,vipHeight);
    }
    //添加认证图标
    float width = aFrame.size.width *0.32;
    float height = aFrame.size.height * 0.32;
    _imageV.hidden=attestation?NO:YES;
    _imageV.frame = CGRectMake(aFrame.size.width-width, aFrame.size.height-height, width, height);
}

//添加点击方法
-(void)headPortraitClick
{
    if (_delegate ){
        [_delegate headPortraitClickAuthor];
    }
}
-(void)layerWithView:(UIImageView *)imageview withColor:(UIColor *)color width:(CGFloat)width
{
    if(!self.maskLayer){
        self.maskLayer = [CAShapeLayer layer];
    }
    if (!self.borderLayer) {
        self.borderLayer = [CAShapeLayer layer];
    }
    self.maskLayer.frame = CGRectMake(0, 0, imageview.width, imageview.height);
    self.borderLayer.frame = CGRectMake(0, 0, imageview.width, imageview.height);
    self.borderLayer.lineWidth = width;
    self.borderLayer.strokeColor = color.CGColor;
    self.borderLayer.fillColor = [UIColor clearColor].CGColor;
    self.bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageview.width, imageview.height) cornerRadius:imageview.height];
    self.maskLayer.path = self.bezierPath.CGPath;
    self.borderLayer.path = self.bezierPath.CGPath;
    [imageview.layer insertSublayer:self.borderLayer atIndex:0];
    [imageview.layer setMask:self. maskLayer];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
