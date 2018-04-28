//
//  SLLiveBottomCollectionViewCell.m
//  ShowLive
//
//  Created by gongxin on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveBottomCollectionViewCell.h"
@interface SLLiveBottomCollectionViewCell()

@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UILabel * textLabel;
@property(nonatomic,strong)UILabel * redLabel;

@end
@implementation SLLiveBottomCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
       
        self.contentView.layer.cornerRadius = 19;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self.contentView addSubview:self.textLabel];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.redLabel];

    }
    return self;
    
}

-(void)setType:(SLLiveBottomViewCellType)type
{
    _type = type;
    
    switch (type) {
        case SLLiveBottomViewCellTypeOnlyImage:
        {
            self.imageView.mj_x = 0;
            self.textLabel.width = 0;
            self.textLabel.text  = @"99K";
        }
            break;
            case SLLiveBottomViewCellTypeText:
        {
            self.imageView.mj_x = 38;
            self.textLabel.width = 38;
            self.textLabel.text  = @"99K";
        }
            break;
            case SLLiveBottomViewCellTypeInput:
        {
            self.imageView.mj_x = 0;
            self.textLabel.mj_x = 38;
            self.textLabel.width = 38*2;
            self.textLabel.text  = @"说点什么...";
        }
            break;
        default:
            break;
    }
    
}

-(void)setIcon:(NSString *)icon
{
    _icon = icon;
    
    [self.imageView setImage:[UIImage imageNamed:icon]];
    self.contentView.hidden = (IsStrEmpty(icon))?YES:NO;
}

-(void)setRedPointHidden:(BOOL)redPointHidden
{
    _redPointHidden =redPointHidden;
    self.redLabel.hidden = redPointHidden;
}

-(UILabel*)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 38, 38)];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

-(UILabel*)redLabel
{
    if (!_redLabel) {
        _redLabel         = [[UILabel alloc]initWithFrame:CGRectMake(27, 2, 12, 12)];
        _redLabel.backgroundColor = [UIColor redColor];
        _redLabel.layer.cornerRadius = 6;
        _redLabel.hidden = YES;
        
    }
    return _redLabel;
}

-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 38, 38)];
        _imageView.layer.cornerRadius = 19;
      
    }
    return _imageView;
}

@end
