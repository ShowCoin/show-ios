//
//  SLTextTableViewCell.m
//  ShowLive
//
//  Created by  JokeSmileZhang on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLTextTableViewCell.h"
#import "YYLabel.h"

@interface SLTextTableViewCell()

@property (weak,nonatomic)YYLabel *contentLabel ;
@property (weak,nonatomic)UIImageView *photoImageView;

@end

@implementation SLTextTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self loadUI];
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
#pragma mark - - UI

- (void)loadUI
{
    self.backgroundColor = [[UIColor clearColor]colorWithAlphaComponent:0];
    
    YYLabel *contentLabel = [[YYLabel alloc]init];
    contentLabel.font = [UIFont systemFontOfSize:15.0f];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    contentLabel.textContainerInset = UIEdgeInsetsMake(3, 8, 1, 8);
    contentLabel.preferredMaxLayoutWidth = self.width -50;
    [self.contentView addSubview:contentLabel];
    
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(self.contentView).with.offset(-12);
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(6);
        make.height.equalTo(self.contentView).with.offset(-5);
    }];
    
    self.contentLabel = contentLabel;
    
}
- (void)bindModel:(SLMessageInfo *)object{
    self.contentLabel.attributedText  = object.attribute;
    if(object.height > 35){
        self.contentLabel.textContainerInset = UIEdgeInsetsMake(3, 8, 1, 3);
    }else{
        self.contentLabel.textContainerInset = UIEdgeInsetsMake(3, 8, 1, 8);
    }
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        [self.contentLabel jk_setRoundedCorners:UIRectCornerAllCorners radius:5];
    });
    
    if(object.type == SLChatRoomMessageTypeDianzan){
        self.contentLabel.backgroundColor = [UIColor whiteColor];
    }else{
        self.contentLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    }
}
@end
