//
//  SLSafeCenterCell.m
//  ShowLive
//
//  Created by vning on 2018/5/8.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLSafeCenterCell.h"

@implementation SLSafeCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.textLab];
        [self.contentView addSubview:self.arrow];
        [self.contentView addSubview:self.lineView];
        self.contentView.backgroundColor = kBlackThemeBGColor;
//        self.textLab.hidden = YES;
//        self.arrow.hidden  = YES;
    }
    return self ;
}

-(UILabel *)title
{
    if (!_title) {
        _title = [UILabel labelWithFont:Font_Regular(15) textColor:kBlackThemetextColor backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _title.frame = CGRectMake(20, 0, 150, 65);
    }
    return _title;
}
-(UILabel *)textLab
{
    if (!_textLab) {
        _textLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80*Proportion375, 15*Proportion375)];
        _textLab.font = Font_Regular(15);
        _textLab.right = kMainScreenWidth - 15*Proportion375;
        _textLab.centerY = 65/2;
        _textLab.textColor = kGrayWith999999;
        _textLab.textAlignment = NSTextAlignmentRight;
    }
    return _textLab;
}
-(UIImageView *)arrow
{
    if (!_arrow) {
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_arrow_right"]];
        _arrow.right = kMainScreenWidth - 15 * Proportion375;
        _arrow.centerY = 66/2;
    }
    return _arrow;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, 1)];
        _lineView.backgroundColor = kBlackThemeColor;
    }
    return _lineView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
