//
//  UserTableViewTypeOneCell.m
//  ShowLive
//
//  Created by vning on 2018/4/5.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "UserTableViewTypeOneCell.h"

@implementation UserTableViewTypeOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        
        UIImageView * userProfileImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_admin_Img"]];
        userProfileImg.left = 13;
        userProfileImg.top = 10;
        userProfileImg.size =CGSizeMake(60, 60);
        userProfileImg.clipsToBounds = YES;
        userProfileImg.layer.cornerRadius = 30;
        userProfileImg.layer.borderColor = kGrayBGColor.CGColor;
        userProfileImg.layer.borderWidth = 1.0;
        [self.contentView addSubview:userProfileImg];
        
        UILabel *userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(userProfileImg.right + 13, 20, 110, 17)];
        userNameLab.font = Font_Regular(17);
        userNameLab.textColor = kthemeBlackColor;
        userNameLab.textAlignment = NSTextAlignmentLeft;
        userNameLab.text = @"admin";
        [self.contentView addSubview:userNameLab];
        
        UILabel *userContentLab = [[UILabel alloc]initWithFrame:CGRectMake(userProfileImg.right + 13, 43, 110, 14)];
        userContentLab.font = Font_Regular(14);
        userContentLab.textColor = kthemeBlackColor;
        userContentLab.textAlignment = NSTextAlignmentLeft;
        userContentLab.text = @"admin too";
        [self.contentView addSubview:userContentLab];
        
        UIImageView * arrowImg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_arrow_right"]];
        arrowImg.right = kMainScreenWidth - 13;
        arrowImg.centerY = 40;
        arrowImg.size = CGSizeMake(20 , 20);
        [self.contentView addSubview:arrowImg];
        
        UIImageView * codeImg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_code_Img"]];
        codeImg.right = arrowImg.left;
        codeImg.centerY = 40;
        codeImg.size = CGSizeMake(20 , 20);
        [self.contentView addSubview:codeImg];
        
    }
    return self ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
