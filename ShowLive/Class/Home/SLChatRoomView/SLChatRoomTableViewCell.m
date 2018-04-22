//
//  SLChatRoomTableViewCell.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatRoomTableViewCell.h"
#import "YYText.h"
#import "SLMessageInfo.h"


#define UILABEL_LINE_SPACE 6

@interface SLChatRoomTableViewCell()

@property (weak,nonatomic)YYLabel *contentLabel ;
@property (weak,nonatomic)UIImageView *photoImageView;

@end

@implementation SLChatRoomTableViewCell

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

#pragma mark - - UI

- (void)loadUI
{
    UIImageView *photoImageView = [[UIImageView alloc]init];
    photoImageView.image = [UIImage imageNamed:@"userhome_admin_Img"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [photoImageView jk_setRoundedCorners:UIRectCornerAllCorners radius:12.5];
    });
    [self.contentView addSubview:photoImageView];
    [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(2.5);
    }];
    self.photoImageView = photoImageView;

    self.backgroundColor = [[UIColor clearColor]colorWithAlphaComponent:0];
    YYLabel *contentLabel = [[YYLabel alloc]init];
    contentLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];

    contentLabel.font = [UIFont systemFontOfSize:15.0f];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    contentLabel.textContainerInset = UIEdgeInsetsMake(3, 8, 1, 3);
    contentLabel.preferredMaxLayoutWidth = self.width -50;
    [self.contentView addSubview:contentLabel];
    
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(self.contentView).with.offset(-50);
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(photoImageView.mas_right).with.offset(9);
        make.height.equalTo(self.contentView).with.offset(-5);
    }];
    self.contentLabel = contentLabel;
}
- (void)bindModel:(SLMessageInfo *)object{
    self.contentLabel.attributedText  = object.attribute;
    NSURL *imageUrl = [NSURL URLWithString:[[NSString dictionaryWithJsonString:object.messageExtra] valueForKey:@"avatar"]];
    [self.photoImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"userhome_admin_Img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGSize newSize=CGSizeMake(25, 25);
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        image = newImage ;
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.contentLabel jk_setRoundedCorners:UIRectCornerAllCorners radius:5];
    });
}
@end
