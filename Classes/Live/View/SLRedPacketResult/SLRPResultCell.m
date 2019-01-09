//
//  SLRPResultCell.m
//  demoPro
//
//  Created by chenyh on 2018/7/31.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLRPResultCell.h"
#import "SLHeadPortrait.h"
#import "SLLevelMarkView.h"

CGFloat const kSLRPResultCellH = 60;
CGFloat const kRPMargin = 18;
static CGFloat const kHeaderViewWH = 30;

static inline CGSize SLFuncGetAttributeStringSize(CGFloat labelW, NSAttributedString *text) {
    return [text boundingRectWithSize:CGSizeMake(labelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}

@interface SLRPResultCell ()

@property (nonatomic, strong) SLHeadPortrait *userView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *sexView;
@property (nonatomic, strong) UILabel *coinLabel;
@property (nonatomic, strong) UILabel *perfectLabel;
@property (nonatomic, strong) UILabel *candyLabel;
@property (nonatomic, strong) SLLevelMarkView *masterLevelView;
@property (nonatomic, strong) SLLevelMarkView *coinLevelView;

@end

@implementation SLRPResultCell

+ (NSString *)kCellID {
    return NSStringFromClass([self class]);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.userView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.sexView];
    [self.contentView addSubview:self.coinLabel];
    [self.contentView addSubview:self.perfectLabel];
    [self.contentView addSubview:self.candyLabel];
    [self.contentView addSubview:self.masterLevelView];
    [self.contentView addSubview:self.coinLevelView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%s", __func__);

    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    CGFloat viewX = kRPMargin;
    CGFloat viewH = kHeaderViewWH;
    CGFloat viewY = (h - viewH) / 2;
    CGFloat viewW = viewH;
    self.userView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    viewX = CGRectGetMaxX(self.userView.frame) + 12;
    viewW = w / 2;
    viewH = self.nameLabel.font.lineHeight;
    self.nameLabel.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    viewY = CGRectGetMaxY(self.nameLabel.frame) + 2;
    viewW = viewH = 12;
    self.sexView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
@end
