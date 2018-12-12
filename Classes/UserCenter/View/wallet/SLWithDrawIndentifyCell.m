//
//  SLWithDrawIndentifyCell.m
//  ShowLive
//
//  Created by vning on 2018/7/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLWithDrawIndentifyCell.h"

@implementation SLWithDrawIndentifyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.statueLab];
        [self.contentView addSubview:self.arrowIma];
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 59*Proportion375, self.width, 1*Proportion375)];
        line.backgroundColor = kGrayWithd7d7d7;
        [self.contentView addSubview:line];
    }
    return self;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(35*Proportion375, 0*Proportion375, 100*Proportion375, 60*Proportion375)];
        _titleLab.font = Font_Medium(17*WScale);
        _titleLab.textColor = kthemeBlackColor;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)statueLab {
    if (!_statueLab) {
        _statueLab = [[UILabel alloc] initWithFrame:CGRectMake((253-35)*Proportion375, 0*Proportion375, 100*Proportion375, 60*Proportion375)];
        _statueLab.font = Font_Medium(17*WScale);
        _statueLab.right =(253-35)*Proportion375;
        _statueLab.textColor = kthemeBlackColor;
        _statueLab.textAlignment = NSTextAlignmentRight;
    }
    return _statueLab;
}

-(UIImageView *)arrowIma
{
    if (!_arrowIma) {
        _arrowIma = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_arrow_right"]];
        _arrowIma.frame = CGRectMake(0, 0, 20*Proportion375, 20*Proportion375);
        _arrowIma.centerY = 30*Proportion375;
        _arrowIma.left = self.statueLab.right + 8*Proportion375;
    }
    return _arrowIma;
}

-(void)setType:(NSInteger)type
{

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
