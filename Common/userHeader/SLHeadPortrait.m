//
//  SLHeadPortrait.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLHeadPortrait.h"
#import "NSString+Validation.h"
@interface SLHeadPortrait()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation SLHeadPortrait
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        vipWidth = self.size.width *0.45;
        vipHeight = self.size.height * 0.7;
        vipLeft  =self.size.width*0.55;
        vipTop  =self.size.width*0.3;
        [self addloadView];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        vipWidth = self.size.width *0.45;
        vipHeight = self.size.height * 0.7;
        vipLeft  =self.size.width*0.55;
        vipTop  =self.size.width*0.3;
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
    vipWidth = self.size.width *0.45;
    vipHeight = self.size.height * 0.7;
    vipLeft  =self.size.width*0.55;
    vipTop  =self.size.width*0.3;
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
        _vipIcon.contentMode = UIViewContentModeScaleAspectFill;
        _vipIcon.hidden = YES;
        [self addSubview:_vipIcon];
    }
    self.frame = frame ;
    
    //添加点击方法
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headPortraitClick)]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
