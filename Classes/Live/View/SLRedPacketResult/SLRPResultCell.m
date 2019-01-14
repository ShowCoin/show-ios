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

/**
 desp

 @param labelW label width
 @param text input text
 @return CGSize
 */
static inline CGSize SLFuncGetAttributeStringSize(CGFloat labelW, NSAttributedString *text) {
    return [text boundingRectWithSize:CGSizeMake(labelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}

/**
 SLRPResultCell
 */
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

/**
 cell id

 @return NSString
 */
+ (NSString *)kCellID {
    return NSStringFromClass([self class]);
}


/**
 initWithStyle

 @param style UITableViewCellStyle
 @param reuseIdentifier reuseIdentifier to cell
 
 @return instancetype
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

/**
 setupUI
 */
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

/**
 layoutSubviews
 */
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
    
    CGRect frame = self.masterLevelView.frame;
    frame.origin.x = CGRectGetMaxX(self.sexView.frame) + 6;
    frame.origin.y = viewY;
    self.masterLevelView.frame = frame;
    
    frame.origin.x = CGRectGetMaxX(self.masterLevelView.frame) + 6;
    self.coinLevelView.frame = frame;
    
    CGSize size = SLFuncGetAttributeStringSize(MAXFLOAT, self.candyLabel.attributedText);
    viewH = size.height;
    viewX = w / 2;
    viewW = size.width;
    viewY = (h - viewH) / 2;
    self.candyLabel.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    size = SLFuncGetAttributeStringSize(MAXFLOAT, self.coinLabel.attributedText);
    viewW = size.width;
    viewH = size.height;
    viewX = w - viewW - kRPMargin;
    viewY = (h - viewH) / 2;
    self.coinLabel.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    if (self.perfectLabel.hidden == NO) {
        size = SLFuncGetAttributeStringSize(MAXFLOAT, self.perfectLabel.attributedText);
        viewY = CGRectGetMaxY(self.coinLabel.frame);
        viewX = w - size.width - kRPMargin;
        self.perfectLabel.frame = CGRectMake(viewX, viewY, size.width, size.height);
    }
}


/**
 SLRPReciveListModel

 @param model model
 */
- (void)setModel:(SLRPReciveListModel *)model {
    _model = model;
    
    self.backgroundColor = model.isOwner ? [UIColor colorWithWhite:0 alpha:0.2] : [UIColor clearColor];
    
    self.nameLabel.text = model.nickname;
    
    self.sexView.image = [UIImage imageNamed:model.sexImage];
    
    self.candyLabel.attributedText = model.candyText;
    
    self.coinLabel.attributedText = model.coinText;
    
    [self.userView setRoundStyle:YES imageUrl:model.avatar imageHeight:35 vip:NO attestation:NO];
    self.perfectLabel.hidden = !model.isPerfect;
    
    [self.masterLevelView updateLevel:@"2"];
    [self.coinLevelView updateLevel:@"3"];
    
    [self.masterLevelView candyInset];
    [self.coinLevelView candyInset];
    
    [self layoutSubviews];
}


#pragma mark - Action

/**
 avatarTapAction
 */
- (void)avatarTapAction {
    if (self.avatarBlock) {
        self.avatarBlock();
    }
}

#pragma mark - lazy

/**
 candyLabel

 @return UILabel
 */
- (UILabel *)candyLabel {
    if (!_candyLabel) {
        _candyLabel = [[UILabel alloc] init];
        _candyLabel.textColor = kBlackThemetextColor;
        _candyLabel.font = [UIFont systemFontOfSize:16];
        _candyLabel.text = @"糖果";
    }
    return _candyLabel;
}

- (UILabel *)perfectLabel {
    if (!_perfectLabel) {
        _perfectLabel = [[UILabel alloc] init];
        _perfectLabel.textColor = kThemeOrangeColor;
        _perfectLabel.textAlignment = NSTextAlignmentRight;
        _perfectLabel.font = [UIFont systemFontOfSize:10];
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:@"redpacket_perfect"];
        CGFloat imgH = _perfectLabel.font.lineHeight;
        CGFloat imgW = (attachment.image.size.width / attachment.image.size.height) * imgH;
        // CGFloat textPaddingTop = (_perfectLabel.font.lineHeight - _perfectLabel.font.pointSize) / 2;
        attachment.bounds = CGRectMake(0, -2, imgW, imgH);
        NSAttributedString *imageAtt = [NSAttributedString attributedStringWithAttachment:attachment];
        
        NSString *text = @" 手气最佳";
        NSDictionary *dict = @{NSFontAttributeName : _perfectLabel.font};
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text attributes:dict];
        [attr insertAttributedString:imageAtt atIndex:0];
        _perfectLabel.attributedText = attr;
    }
    return _perfectLabel;
}

- (UILabel *)coinLabel {
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] init];
        _coinLabel.textColor = kBlackThemetextColor;
        _coinLabel.textAlignment = NSTextAlignmentRight;
        _coinLabel.font = [UIFont systemFontOfSize:12];
    }
    return _coinLabel;
}

- (UIImageView *)sexView {
    if (!_sexView) {
        _sexView = [[UIImageView alloc] init];
    }
    return _sexView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kBlackThemetextColor;
        _nameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _nameLabel;
}

- (SLHeadPortrait *)userView {
    if (!_userView) {
        _userView = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(0, 0, kHeaderViewWH, kHeaderViewWH)];
        _userView.userInteractionEnabled = YES;
        [_userView removeTap];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarTapAction)];
        [_userView addGestureRecognizer:tap];
    }
    return _userView;
}

- (SLLevelMarkView *)masterLevelView {
    if (!_masterLevelView) {
        CGRect frame = CGRectMake(0, 0, 24, 12);
        _masterLevelView = [[SLLevelMarkView alloc] initWithFrame:frame withType:LevelType_Host];
    }
    return _masterLevelView;
}

- (SLLevelMarkView *)coinLevelView {
    if (!_coinLevelView) {
        CGRect frame = CGRectMake(0, 0, 24, 12);
        _coinLevelView = [[SLLevelMarkView alloc] initWithFrame:frame withType:LevelType_ShowCoin];
    }
    return _coinLevelView;
}

@end



#import "SLGetCoinInfo.h"

@implementation SLGetCandyInfoModel {
    SLGetCoinInfo *coinInfo_;
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"reciveList" : [SLRPReciveListModel class],
             @"sender" : [SLRPUserModel class]
             };
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"congraText", @"tipText", @"coinNameText", @"owner", @"rmb_rate"];
}

- (void)getRMBRate {
    if (coinInfo_ ) {
        [coinInfo_ cancel];
        coinInfo_ = nil;
    }
    
    coinInfo_ = [SLGetCoinInfo action];
    coinInfo_.coin_type = self.coin_type;
    @weakify(self)
    [coinInfo_ startRequestSucess:^(id result) {
        @strongify(self)
        self.rmb_rate = result[@"rmb_rate"];;
    } FaildBlock:^(NSError *error) {
        @strongify(self)
        self.rmb_rate = @"0";
    }];
}

#pragma mark - setter

- (NSString *)coinNameText {
    if (!_coinNameText) {
        NSDictionary *info =  [SLSystemConfigModel shared].coinTypes;
        NSDictionary *showInfo = info[self.coin_type];
        // type 英文
        // name 中文
        if ([showInfo.allKeys containsObject:@"type"]) {
            _coinNameText = showInfo[@"type"];
        } else {
            _coinNameText = @"未知";
        }
        [self getRMBRate];
    }
    return _coinNameText;
}

- (NSString *)congraText {
    if (!_congraText) {
        if (IsValidString(self.comment)) {
            _congraText = self.comment;
        } else {
            _congraText = @"恭喜发财，大吉大利";
        }
    }
    return _congraText;
}

- (NSString *)tipText {
    if (!_tipText) {
        __block SLRPReciveListModel *owner = nil;
        [self.reciveList enumerateObjectsUsingBlock:^(SLRPReciveListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isOwner) {
                owner = obj;
            }
        }];

        NSString *totalCandy = [NSString stringWithFormat:@"%zd个糖果共%@秀币", self.candy_num, self.coin_num];

        NSString *ownerGetCandy = @"您未抢到";
        if (owner.candy_num != 0) {
            ownerGetCandy = [NSString stringWithFormat:@"您抢到%zd个糖果", owner.candy_num];
        }
        
        if (self.candy_remain != 0) {
            _tipText = [NSString stringWithFormat:@"%@, %@", totalCandy, ownerGetCandy];
        } else {
            _tipText = [NSString stringWithFormat:@"%@，%zd秒抢光，%@",
                        totalCandy, self.duration, ownerGetCandy];
        }
    }
    return _tipText;
}

@end

@implementation SLRPUserModel

@end

@implementation SLRPReciveListModel

+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"perfect", @"owner", @"coinType", @"coinText", @"sexImage", @"candyText"];
}

+ (instancetype)ownerModel {
    SLRPReciveListModel *model = [[self alloc] init];
    model.candy_num = 0;
    model.coin_num = @"0";
    model.avatar = AccountUserInfoModel.avatar;
    model.nickname = AccountUserInfoModel.nickname;
    model.gender = [AccountUserInfoModel.gender integerValue];
    model.uid = AccountUserInfoModel.uid;
    model.owner = YES;
    model.perfect = NO;
    
    return model;
}

- (NSAttributedString *)candyText {
    if (!_candyText) {
        NSString *text = [NSString stringWithFormat:@"糖果 x %zd", self.candy_num];
        NSDictionary *attrDict = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text attributes:attrDict];
        [attr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}
                      range:NSMakeRange(3, text.length - 3)];
        _candyText = attr;
    }
    return _candyText;
}

- (NSAttributedString *)coinText {
    if (!_coinText) {
        NSString *text = [NSString stringWithFormat:@"%@ %@", self.coin_num, self.coinType];
        NSDictionary *attrDict = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text attributes:attrDict];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, text.length - self.coinType.length)];
        _coinText = attr;
    }
    return _coinText;
}

- (NSString *)sexImage {
    if (!_sexImage) {
        _sexImage = self.gender == 1 ? @"redpacket_sex_man" : @"redpacket_sex_woman";
    }
    return _sexImage;
}

@end
