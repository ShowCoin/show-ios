//
//  SLChatRoomTableViewCell.m
//  ShowLive
//
//  Created by  JokeSmileZhang on 2018/4/10.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatRoomTableViewCell.h"
#import "YYText.h"
#import "SLMessageInfo.h"
#import "SLHeadPortrait.h"

#define UILABEL_LINE_SPACE 6

@interface SLChatRoomTableViewCell()

@property (weak,nonatomic)YYLabel *contentLabel ;
@property (weak,nonatomic)SLHeadPortrait *photoImageView;

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
    SLHeadPortrait *photoImageView = [[SLHeadPortrait alloc]initWithFrame:CGRectMake(10,4.5, 25, 25)];
    [self.contentView addSubview:photoImageView];
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
    NSString *imageUrl =[[NSString dictionaryWithJsonString:object.messageExtra] valueForKey:@"avatar"];
    self.photoImageView.imageView. backgroundColor = [UIColor redColor];
    [self.photoImageView setRoundStyle:YES imageUrl:imageUrl  imageHeight:25 vip:object.isVip attestation:NO];
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        [self.contentLabel jk_setRoundedCorners:UIRectCornerAllCorners radius:5];
    });
    if(object.height > 35){
        self.contentLabel.textContainerInset = UIEdgeInsetsMake(3, 8, 1, 3);
    }else{
        self.contentLabel.textContainerInset = UIEdgeInsetsMake(3, 8, 1,5 );
    }
}
@end
