//
//  SLConvListSystemTableViewCell.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/30.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLConvListSystemTableViewCell.h"

@implementation SLConvListSystemTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = Color(@"FBFBFB");
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    //全cell点击事件
    UIButton * bgView = [[UIButton alloc]initWithFrame:self.bounds];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [bgView addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    
    //添加seeu icon
    _iconImage = [[UIImageView alloc]init];
    _iconImage.userInteractionEnabled = YES;
    _iconImage.frame = CGRectMake(15, 15, 45, 45);
    _iconImage.backgroundColor = [UIColor whiteColor];
    _iconImage.layer.masksToBounds = YES;
    _iconImage.layer.cornerRadius = _iconImage.height/2;
    _iconImage.layer.borderColor = HexRGBAlpha(0xb2b2b2, 0.3).CGColor;
    _iconImage.layer.borderWidth = 1;
    [_iconImage setImage:[UIImage imageNamed:@"offical_Icon"]];
    _iconImage.contentMode = UIViewContentModeScaleAspectFill;
    [bgView addSubview:_iconImage];
    
    
    
    _iconVImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"offical_v_icon"]];
    _iconVImage.frame = CGRectMake(15+30, 15+30, 16, 16);
    [bgView addSubview:_iconVImage];
    
    
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.backgroundColor = [UIColor clearColor];
    headBtn.frame = _iconImage.frame;
    [bgView addSubview:headBtn];
    [headBtn addTarget:self action:@selector(didTapHeadImage) forControlEvents:UIControlEventTouchUpInside];
    
    //添加小红点
    _redPoint = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 21 - 7, 37.5, 7, 7)];
    _redPoint.layer.cornerRadius = 3.5;
    _redPoint.backgroundColor = kThemeRedColor;
    [bgView addSubview:_redPoint];
    
    //添加标题
    
    _titleLab = [UILabel labelWithFrame:CGRectMake(70, 20, kMainScreenWidth-128, 15) text:@"SEEU时刻" textColor:kthemeBlackColor font:[UIFont boldSystemFontOfSize:14] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    //        [_titleLab sizeToFit];
    [bgView addSubview:_titleLab];
    
    //添加消息内容label
    _contentLabel = [UILabel labelWithFrame:CGRectMake(70, _titleLab.bottom+3, kMainScreenWidth-100, 20) text:@"" textColor:RGBCOLOR(156, 158, 171) font:[UIFont systemFontOfSize:12] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    [bgView addSubview:_contentLabel];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(70, 74.5, kMainScreenWidth - 15, 0.5)];
    lineView.backgroundColor = kSeparationColor;
    [bgView addSubview:lineView];
    
    [self.contentView addSubview:bgView];
}


-(void)selectAction
{
    if (_selectedBlock) {
        _selectedBlock(self);
    }
}


- (void)didTapHeadImage
{
    if (_didTapHeadBlock) {
        _didTapHeadBlock(self);
    }
}

@end
