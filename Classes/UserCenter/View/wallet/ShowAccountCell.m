//
//  ShowAccountCell.m
//  ShowLive
//
//  Created by 周华 on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAccountCell.h"

@implementation ShowAccountCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = kBlackWith17;
        [self.contentView addSubview:self.coinImage];
        [self.contentView addSubview:self.coinNamelabel];
        [self.contentView addSubview:self.coinDetailNamelabel];
        [self.contentView addSubview:self.coinNumLabel];
        [self.contentView addSubview:self.RmbNumLabel];
        [self.contentView addSubview:self.FreezeNumLabel];
        [self.contentView addSubview:self.percentBgView];
//        [self.contentView addSubview:self.percentView];

//        [self.contentView addSubview:self.lineView];
    }
    return self;
    
}

- (UIImageView*)coinImage{
    if (!_coinImage) {
        _coinImage = [[UIImageView alloc]initWithFrame:CGRectMake(16*Proportion375, 13*Proportion375, 34*Proportion375, 34*Proportion375)];
        _coinImage.backgroundColor = [UIColor clearColor];
    }
    return _coinImage;
}
-(UILabel*)coinNamelabel
{
    if (!_coinNamelabel) {
        _coinNamelabel = [UILabel labelWithFrame:CGRectMake(_coinImage.right +8*Proportion375, 8*Proportion375,  100*Proportion375, 16*Proportion375) text:@"" textColor:kThemeWhiteColor font:Font_Regular(16*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _coinNamelabel;
}
-(UILabel*)coinDetailNamelabel
{
    if (!_coinDetailNamelabel) {
        _coinDetailNamelabel = [UILabel labelWithFrame:CGRectMake(_coinImage.right +8*Proportion375, _coinNamelabel.bottom + 6*Proportion375,  100*Proportion375, 11*Proportion375) text:@"" textColor:kTextWith8b font:Font_Regular(11*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _coinDetailNamelabel;
}
-(UILabel*)coinNumLabel
{
    if (!_coinNumLabel) {
        _coinNumLabel = [UILabel labelWithFrame:CGRectMake(kMainScreenWidth/2,  8*Proportion375,  kMainScreenWidth/2-16*Proportion375, 21*Proportion375) text:@"" textColor:kTextWhitef7f7f7 font:Font_engRegular(21*WScale)   backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        
    }
    return _coinNumLabel;
}
-(UILabel*)RmbNumLabel
{
    if (!_RmbNumLabel) {
        _RmbNumLabel = [UILabel labelWithFrame:CGRectMake(kMainScreenWidth/2, 29*Proportion375, kMainScreenWidth/2-16*Proportion375, 11*Proportion375) text:@"" textColor:kTextWith8b font:Font_engRegular(11*WScale)   backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
    }
    return _RmbNumLabel;
}
-(UILabel*)FreezeNumLabel
{
    if (!_FreezeNumLabel) {
        _FreezeNumLabel = [UILabel labelWithFrame:CGRectMake(kMainScreenWidth/2, 43*Proportion375, kMainScreenWidth/2-16*Proportion375, 11*Proportion375) text:@"" textColor:kTextWith8b font:Font_engRegular(11*WScale)   backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
    }
    return _FreezeNumLabel;
}
- (UIView*)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(20*Proportion375, 86.5*Proportion375, kMainScreenWidth - 20*Proportion375, 0.6*Proportion375)];
        _lineView.backgroundColor = kSeparationColor;
    }
    return _lineView;
}
-(UILabel*)percentBgView
{
    if (!_percentBgView) {
        _percentBgView = [[UILabel alloc] initWithFrame:CGRectMake(_coinNamelabel.left, _coinNamelabel.bottom, 132*Proportion375, 9*Proportion375)];
        _percentBgView.backgroundColor = kBlackWith27;
        _percentBgView.textAlignment = NSTextAlignmentRight;
        _percentBgView.font = Font_Regular(8*Proportion375);
        _percentBgView.textColor = [UIColor whiteColor];
        [_percentBgView addSubview:self.percentView];
        [_percentBgView addSubview:self.percentTextView];

    }
    return _percentBgView;
}
-(UIView*)percentView
{
    if (!_percentView) {
        _percentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 9*Proportion375)];
//        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
//        gradientLayer.frame = CGRectMake(0, 0, 100, 9*Proportion375);
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1, 0);
//        gradientLayer.locations = @[@(0.0),@(1.0)];
//        [gradientLayer setColors:@[(id)HexRGBAlpha(0xbd9c77, 1).CGColor,(id)HexRGBAlpha(0xf8d2a5, 1).CGColor]];
//        [_percentView.layer addSublayer:gradientLayer];
    }
    return _percentView;
}
-(UILabel*)percentTextView
{
    if (!_percentTextView) {
        _percentTextView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _percentBgView.width, _percentBgView.height)];
        _percentTextView.shadowColor  = [UIColor colorWithWhite:0 alpha:0.2];
        _percentTextView.shadowOffset = CGSizeMake(0, 1);
        _percentTextView.backgroundColor = [UIColor clearColor];
        _percentTextView.textAlignment = NSTextAlignmentRight;
        _percentTextView.font = Font_Regular(8*Proportion375);
        _percentTextView.textColor = [UIColor whiteColor];
    }
    return _percentTextView;
}
-(void)setPercent:(CGFloat)percent
{
    if (percent) {
        _percentView.hidden = NO;
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, _percentBgView.width * percent, 9*Proportion375);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.0),@(1.0)];
        [gradientLayer setColors:@[(id)HexRGBAlpha(0xbd9c77, 1).CGColor,(id)HexRGBAlpha(0xf8d2a5, 1).CGColor]];
        [_percentView.layer addSublayer:gradientLayer];
    }else{
        _percentView.hidden = YES;
    }
    [_percentTextView setText:[NSString stringWithFormat:@"%.f%@",percent*100,@"%"]];
    
}
-(void)setType:(NSInteger)type
{
    if (type == 1) {
        _coinDetailNamelabel.hidden = YES;
        _coinNamelabel.top = _coinImage.top;
        _percentBgView.top = _coinNamelabel.bottom + 6*Proportion375;
    }else if (type == 2){
        _coinDetailNamelabel.hidden = NO;
        _coinNamelabel.top = 8*Proportion375;
        _coinDetailNamelabel.top = _coinNamelabel.bottom + 6*Proportion375;
        _percentBgView.top = _coinDetailNamelabel.bottom + 3*Proportion375;

    }
}

- (void)bindModel:(NSString *)object{
    _coinNumLabel.text = object?:@"0";
    _RmbNumLabel.text = [NSString stringWithFormat:@"￥%.2f",object?object.floatValue/100:0];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
