//
//  AddressChooseCell.m
//  ShowLive
//
//  Created by vning on 2018/4/3.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "AddressChooseCell.h"

@implementation AddressChooseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.headportrait];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.addressLab];
        [self.contentView addSubview:self.statuLab];
        [self.contentView addSubview:self.statuImg];
        [self.contentView addSubview:self.lineView];

    }
    return self;
}
-(SLHeadPortrait *)headportrait
{
    if (!_headportrait) {
        _headportrait = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(14, 11, 38, 38)];
        [_headportrait setRoundStyle:YES imageUrl:nil imageHeight:38 vip:NO attestation:NO];
    }
    return _headportrait;
}
-(UILabel*)nameLab
{
    if (!_nameLab) {
        _nameLab = [UILabel labelWithFrame:CGRectMake(self.headportrait.right + 12*Proportion375, 15,  290*Proportion375, 18) text:@"WEINING" textColor:kthemeBlackColor font:Font_Regular(18)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _nameLab;
}
-(UILabel*)addressLab
{
    if (!_addressLab) {
        _addressLab = [UILabel labelWithFrame:CGRectMake(self.headportrait.right + 12*Proportion375, 39,  290*Proportion375, 11) text:@"0XSKAJKFJALKJKAJLKFJLKASJFLKJASKLFJ" textColor:kGrayWith999999 font:Font_Regular(10)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _addressLab;
}
-(UILabel*)statuLab
{
    if (!_statuLab) {
        _statuLab = [UILabel labelWithFrame:CGRectMake(12*Proportion375, 37,  100, 14) text:@"已认证" textColor:kthemeBlackColor font:Font_Medium(14)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _statuLab.right = kMainScreenWidth - 20;
        _statuLab.centerY = 30;
        
    }
    return _statuLab;
}
-(UIImageView *)statuImg
{
    if (!_statuImg) {
        _statuImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45, kMainScreenWidth, 15)];
        [_statuImg setImage:[UIImage imageNamed:@"account_TR_bottom"]];
        _statuImg.hidden = YES;
    }
    return _statuImg;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, kMainScreenWidth, 1)];
        _lineView.backgroundColor = kSeparationColor;
    }
    return _lineView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self changeSelectionColorForSelectedOrHiglightedState:selected];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    [self changeSelectionColorForSelectedOrHiglightedState:highlighted];
}
-(void)setModel:(SLAddressList *)model
{
    _nameLab.text = model.name;
    _statuLab.text = model.isVerify.integerValue==1?@"已认证":@"未认证";
    _addressLab.text = model.address;
}
- (void)changeSelectionColorForSelectedOrHiglightedState:(BOOL)state
{
    if (state) {
        //选中时候的样式
        _statuImg.hidden = NO;
        _lineView.hidden  = YES;
    }else{
        _statuImg.hidden = YES;
        _lineView.hidden = NO;
    }
}

@end
