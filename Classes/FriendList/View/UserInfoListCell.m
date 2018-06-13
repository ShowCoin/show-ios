//
//  UserInfoListCell.m
//  ShowLive
//
//  Created by vning on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "UserInfoListCell.h"

@implementation UserInfoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.text];
        [self.contentView addSubview:self.textLabel];
        [self.contentView addSubview:self.avatar];
        [self.contentView addSubview:self.arrow];
    }
    return self ;
}

- (UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 80, 15)];
        _name.font = Font_Regular(15);
        _name.textColor = kthemeBlackColor;
        _name.textAlignment = NSTextAlignmentLeft;
    }
    return _name;
}

- (UILabel *)text
{
    if (!_text) {
        _text = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 270, 15)];
        _text.right = KScreenWidth - 50;
        _text.font = Font_Regular(15);
        _text.textColor = kGrayWith999999;
        _text.textAlignment = NSTextAlignmentRight;
    }
    return _text;
}

- (UIImageView *)arrow
{
    if (!_arrow) {
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_arrow_right"]];
        _arrow.right = KScreenWidth - 15;
        
    }
    return _arrow;
}

- (SLHeadPortrait *)avatar
{
    if (!_avatar) {
        _avatar = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _avatar.size = CGSizeMake(40, 40);
        _avatar.right = KScreenWidth - 50;
        
    }
    return _avatar;
}

- (void)setCelltype:(CellType)celltype{
    if (celltype == firstcellType) {
        self.name.centerY = self.text.centerY = self.arrow.centerY = self.avatar.centerY = 30;
        self.text.hidden = YES;
        self.avatar.hidden = NO;
    }else{
        self.name.centerY = self.text.centerY= self.arrow.centerY = self.avatar.centerY = 25;
        self.avatar.hidden = YES;
        self.text.hidden = NO;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
