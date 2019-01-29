//
//  NewTopListCell.m
//  ShowLive
//
//  Created by vning on 2019/1/25.
//  Copyright © 2019 vning. All rights reserved.
//

#import "NewTopListCell.h"
#import "NSString+SLMoney.h"

@implementation NewTopListCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.headPortraitBg];
        [self.contentView addSubview:self.headPortraitIsLiveBg];
        [self.contentView addSubview:self.headPortrait];
        self.headPortraitBg.center = self.headPortrait.center;
        self.headPortraitIsLiveBg.center = self.headPortrait.center;
        [self.contentView addSubview:self.NumImg];
        [self.contentView addSubview:self.NumLab];
        [self.contentView addSubview:self.nickNameLabel];
        [self.contentView addSubview:self.sexImg];
        [self.contentView addSubview:self.detailNameLable];
        [self.contentView addSubview:self.masterLevel];
        [self.contentView addSubview:self.showLevel];
        [self.contentView addSubview:self.LabFir];
        [self.contentView addSubview:self.showCoin];
        [self.contentView addSubview:self.LabSec];
        [self.contentView addSubview:self.LabThird];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.attentionButton];

        self.backgroundColor = kBlackWith1c;
        
    }
    
    return self;
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
