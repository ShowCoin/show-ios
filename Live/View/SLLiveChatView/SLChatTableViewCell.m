//
//  SLChatTableViewCell.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/19.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatTableViewCell.h"


@interface SLChatTableViewCell()

@property (weak,nonatomic)UIImageView *photoView;
@property (weak,nonatomic)UILabel *nameLabel;
@property (weak,nonatomic)UILabel *descLabel;

@end

@implementation SLChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self configSubViews];
    }
    return self ;
}

- (void)configSubViews{
    UIImageView *photoImageView = [[UIImageView alloc]init];
    photoImageView.layer.masksToBounds = YES ;
    photoImageView.layer.cornerRadius = 20 ;
    [self.contentView addSubview:photoImageView];
    [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    self.photoView = photoImageView ;
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:nameLabel];
    [nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoImageView.mas_right).with.offset(10);
        make.top.equalTo(photoImageView);
    }];
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
