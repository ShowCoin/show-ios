//
//  SLUserInfoListCell.m
//  ShowLive
//
//  Created by vning on 2018/4/25.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLUserInfoListCell.h"

@implementation SLUserInfoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.textLab];
        [self.contentView addSubview:self.detailTextLab];
        [self.contentView addSubview:self.arrow];
        [self.contentView addSubview:self.lineView];
        self.textLab.hidden = YES;
        self.detailTextLab.hidden = YES;
        self.arrow.hidden  = YES;
    }
    return self ;
}
-(UILabel *)title
{
    if (!_title) {
        _title = [UILabel labelWithFont:Font_Regular(15*Proportion375) textColor:kGrayWith999999 backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _title.frame = CGRectMake(20, 0, 200*Proportion375, 15*Proportion375);
        _title.centerY = 26*Proportion375;
        _title.text = @"33";
    }
    return _title;
}
-(UILabel *)textLab
{
    if (!_textLab) {
        _textLab = [[UILabel alloc]initWithFrame:CGRectMake(90*Proportion375, 25, 250*Proportion375, 15*Proportion375)];
        _textLab.font = Font_Regular(15);
        _textLab.centerY = 26*Proportion375;
        _textLab.textColor = kGrayWith999999;
        _textLab.textAlignment = NSTextAlignmentLeft;
    }
    return _textLab;
}
-(UILabel *)detailTextLab
{
    if (!_detailTextLab) {
        _detailTextLab = [[UILabel alloc]initWithFrame:CGRectMake(90*Proportion375, 25, 250*Proportion375, 9)];
        _detailTextLab.font = Font_Regular(9);
        _detailTextLab.top = _textLab.bottom + 2*Proportion375;
        _detailTextLab.textColor = kGrayWith999999;
        _detailTextLab.textAlignment = NSTextAlignmentLeft;
    }
    return _detailTextLab;
}


-(UIImageView *)arrow
{
    if (!_arrow) {
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_arrow_right"]];
        _arrow.right = KScreenWidth - 15;
        _arrow.centerY = 26*Proportion375;
        
    }
    return _arrow;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 51, kMainScreenWidth, 1)];
        _lineView.backgroundColor = kBlackThemeColor;
    }
    return _lineView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
