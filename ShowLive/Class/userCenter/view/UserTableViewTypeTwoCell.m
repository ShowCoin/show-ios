//
//  UserTableViewTypeTwoCell.m
//  ShowLive
//
//  Created by vning on 2018/4/5.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "UserTableViewTypeTwoCell.h"
@interface UserTableViewTypeTwoCell()


@end
@implementation UserTableViewTypeTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        
        self.walletImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_wallet_Img"]];
        self.walletImg.left = 13;
        self.walletImg.centerY = 40;
        self.walletImg.size =CGSizeMake(30, 30);
        [self.contentView addSubview:self.walletImg];
        
        self.walletLab = [[UILabel alloc]initWithFrame:CGRectMake(self.walletImg.right + 10, 33, 80, 17)];
        self.walletLab.font = Font_Regular(17);
        self.walletLab.textColor = kthemeBlackColor;
        self.walletLab.textAlignment = NSTextAlignmentLeft;
//        self.walletLab.text = STRING_ACCOUNT_WALLET_16;
        [self.contentView addSubview:self.walletLab];
        
        self.mCountLab1 = [[UILabel alloc]initWithFrame:CGRectMake(165, 25, 175, 12)];
        self.mCountLab1.font = Font_Regular(11);
        self.mCountLab1.textColor = kthemeBlackColor;
        self.mCountLab1.textAlignment = NSTextAlignmentLeft;
        self.mCountLab1.text = @"SHOW    83893940.83839";
//        self.mCountLab1.text = [NSString stringWithFormat:STRING_ACCOUNT_COINNAME_17,@"    83893940.83839"];
        [self.contentView addSubview:self.mCountLab1];
        
        self.mCountLab2 = [[UILabel alloc]initWithFrame:CGRectMake(165, 44, 175, 12)];
        self.mCountLab2.font = Font_Regular(11);
        self.mCountLab2.textColor = kthemeBlackColor;
        self.mCountLab2.textAlignment = NSTextAlignmentLeft;
        self.mCountLab2.text = @"CNY       9879.88";
//        self.mCountLab2.text = [NSString stringWithFormat:STRING_ACCOUNT_MONEYUNIT_18,@"       9879.88"];

        [self.contentView addSubview:self.mCountLab2];
        
        
        UIImageView * arrowImg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_arrow_right"]];
        arrowImg.right = kMainScreenWidth - 13;
        arrowImg.centerY = 40;
        arrowImg.size = CGSizeMake(20 , 20);
        arrowImg.clipsToBounds = YES;
        [self.contentView addSubview:arrowImg];

    }
    return self ;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
