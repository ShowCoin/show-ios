//
//  UserTableViewTypeThreeCell.m
//  ShowLive
//
//  Created by vning on 2018/4/5.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "UserTableViewTypeThreeCell.h"

@implementation UserTableViewTypeThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        
    }
    return self ;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
