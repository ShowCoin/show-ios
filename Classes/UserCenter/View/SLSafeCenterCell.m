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


@end
