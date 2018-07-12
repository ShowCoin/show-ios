//
//  SLIdCardVIew.m
//  test
//
//  Created by chenyh on 2018/7/2.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLAuthenticationView.h"

static CGFloat const kMargin = 15;

@interface SLAuthenticationView ()

@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, weak) UILabel *detialLabel;
@property (nonatomic, weak) SLAuthImageView *imageView;
@property (nonatomic, weak) UIImageView *placeholderView;
@property (nonatomic, weak) UILabel *errorLabel;
@property (nonatomic, copy) NSString *placeholder;

@end

@implementation SLAuthenticationView

/**
 initWithFrame

 @param frame frame
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

/**
 setupUI
 */
- (void)setupUI {
    self.backgroundColor = SLNormalColor;
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    self.textLabel = label;
    
    label = [[UILabel alloc] init];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    [self addSubview:label];
    self.detialLabel = label;
    
    SLAuthImageView *imageView = [[SLAuthImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    //imageView2.backgroundColor = [UIColor purpleColor];
    [self addSubview:imageView2];
    self.placeholderView = imageView2;
    
    label = [[UILabel alloc] init];
    label.textColor = [UIColor redColor];//
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    label.hidden = YES;
    [self addSubview:label];
    self.errorLabel = label;
}

/**
 layoutSubviews
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    w = w == 0 ? UIScreen.mainScreen.bounds.size.width : w;

    CGFloat labelW = w - kMargin * 2;
    CGFloat labelH = self.textLabel.font.lineHeight;
    [self.textLabel sizeToFit];
    CGFloat textW = self.textLabel.frame.size.width;
    self.textLabel.frame = CGRectMake(kMargin, 15, textW, labelH);
    
    CGFloat detialX = 0;
    CGFloat detialY = 0;
    CGFloat detialH = 0;
    CGFloat detialW = 0;
    if (self.type == SLIdCardTypeHand) {
        detialX = kMargin;
        detialY = CGRectGetMaxY(self.textLabel.frame);
        detialW = labelW;
        detialH = [self.detialLabel.text boundingRectWithSize:CGSizeMake(detialW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.detialLabel.font} context:nil].size.height;
    } else {
        detialH = self.detialLabel.font.lineHeight;
        detialX = CGRectGetMaxX(self.textLabel.frame) + 5;
        detialY = CGRectGetMaxY(self.textLabel.frame) - detialH;
        detialW = labelW - CGRectGetMaxX(self.textLabel.frame) - kMargin * 2;
    }
    self.detialLabel.frame = CGRectMake(detialX, detialY, detialW, detialH);
    
    CGFloat imageW = (w - kMargin * 3) / 2;
    CGFloat imageY = CGRectGetMaxY(self.detialLabel.frame) + 15;
    // w1 / h1 = w2 / h2
    // h2 w1 = w2 h1
    CGFloat kImageViewH = imageW *  110 / 170;
    self.imageView.frame = CGRectMake(kMargin, imageY, imageW, kImageViewH);
    
    CGFloat placeX = CGRectGetMaxX(self.imageView.frame) + kMargin;
    self.placeholderView.frame = CGRectMake(placeX, imageY, imageW, kImageViewH);
    
    if (self.errorLabel.hidden == NO) {
        CGFloat errorY = CGRectGetMaxY(self.placeholderView.frame) + 15;
        CGFloat errorH = [self.errorLabel.text boundingRectWithSize:CGSizeMake(labelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.errorLabel.font} context:nil].size.height;
        self.errorLabel.frame = CGRectMake(kMargin, errorY, labelW, errorH);
    }
}

/**
 tapAction
 */
- (void)tapAction {
    NSLog(@"%s", __func__);
    if (self.clickBlock) {
        self.clickBlock();
    }
}

/**
 setType

 @param type SLIdCardType
 */
- (void)setType:(SLIdCardType)type {
    _type = type;
    NSString *pString = nil;
    if (type == SLIdCardTypePros) {
        self.textLabel.text = @"证件正面";
        self.detialLabel.text = @"为方便审核，请上传清晰的图片";
        self.placeholder = @"auth_pros_add";
        pString = @"auth_pros_normal";
    } else if (type == SLIdCardTypeCons) {
        self.textLabel.text = @"证件反面";
        self.detialLabel.text = @"为方便审核，请上传清晰的图片";
        self.placeholder = @"auth_cons_add";
        pString = @"auth_cons_normal";
    } else if (type == SLIdCardTypeHand) {
        self.textLabel.text = @"手持证件照片";
        self.detialLabel.text = @"1.手持证件照通过标准： 2.人物头像清晰； 3.身份证件信息清晰；4.证件照旁展示一张写有：“SHOW COIN+申请日期”的纸张信息；5.完整的展示您的手臂持证。";
        self.placeholder = @"auth_hand_add";
        pString = @"auth_hand_normal";
    }
    self.imageView.image = [UIImage imageNamed:self.placeholder];
    self.placeholderView.image = [UIImage imageNamed:pString];
    [self layoutSubviews];
}

/**
 showAuthImageType

 @param type SLAuthImageTypei
 */
- (void)showAuthImageType:(SLAuthImageType)type {
    SLAuthImageView *imageV = (SLAuthImageView *)self.imageView;
    imageV.type = type;
}

- (void)setErrorMsg:(NSString *)errorMsg {
    _errorMsg = errorMsg;
    
    self.errorLabel.text = errorMsg;
    self.errorLabel.hidden = errorMsg.length > 0 ? NO : YES;
    [self layoutSubviews];
}

- (CGFloat)viewH {
    CGFloat maxH = 0;
    if (self.errorLabel.hidden == NO) {
        maxH = CGRectGetMaxY(self.errorLabel.frame);
    } else {
        maxH = CGRectGetMaxY(self.placeholderView.frame);;
    }
    
    if (self.type == SLIdCardTypeHand) {
        maxH += 15;
    }
    return maxH;
}

@end

@interface SLAICountryView ()

@property (nonatomic, weak) UILabel *ctextLabel;
@property (nonatomic, weak) UILabel *cdetialLabel;
//@property (nonatomic, weak) UIImageView *accessoryView;

@end

/**
 SLAICountryView
 */
@implementation SLAICountryView


+ (instancetype)countryView {
    SLAICountryView *view = [[SLAICountryView alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    return view;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.backgroundColor = SLNormalColor;
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.text = @"国籍 / 地区";
    label.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:label];
    self.ctextLabel = label;
    
    label = [[UILabel alloc] init];
    label.text = @"中国";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:label];
    self.cdetialLabel = label;
    
    //    UIImageView *imageView = [[UIImageView alloc] init];
    //    imageView.backgroundColor = [UIColor purpleColor];
    //    [self addSubview:imageView];
    //    self.accessoryView = imageView;
}

/**
 layoutSubviews
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    CGFloat labelW = (w - kMargin * 2) / 2;
    self.ctextLabel.frame = CGRectMake(kMargin, 0, labelW, h);
    
    CGFloat accessoryW = self.accessoryView.frame.size.width;
    CGFloat accessoryX = w - kMargin - accessoryW;
    //    self.accessoryView.frame = CGRectMake(accessoryX, 0, accessoryW, h);
    
    CGFloat detialX = accessoryX - labelW - 8;
    self.cdetialLabel.frame = CGRectMake(detialX, 0, labelW, h);
}

@end

@interface SLCountryModalView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, weak) UIButton *close;
@property (nonatomic, weak) UIPickerView *picker;
@property (nonatomic, strong) NSArray *countries;

@end


/**
 SLCountryModalView
 */
@implementation SLCountryModalView

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)initView
{
    [super initView];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.countries = @[@"中国", @"中国以外"];
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    picker.dataSource = self;
    [self addSubview:picker];
    self.picker = picker;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //button.backgroundColor = [UIColor purpleColor];
    [button setImage:[UIImage imageNamed:@"live_chat_close"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:button aboveSubview:self.picker];
    self.close = button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    CGFloat pickerY = 0;
    CGFloat pickerH = h - pickerY;
    self.picker.frame = CGRectMake(0, pickerY, w, pickerH);
    
    CGFloat closeWH = 30;
    CGFloat closeX = w - closeWH - 10;
    self.close.frame = CGRectMake(closeX, 0, closeWH, closeWH);
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.countries.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

/**
 titleForRow title

 @param pickerView pickerView
 @param row row
 @param component component
 @return NSString
 */
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.countries[row];
}

//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {// 15 font 333333color
//
//    return [[NSAttributedString alloc] initWithString:self.countries[row]
//                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
//                                                        NSForegroundColorAttributeName : [UIColor darkGrayColor]
//                                                        }];
//}

/**
 custom view show

 @param pickerView pickerView
 @param row row
 @param component component
 @param view view
 @return UIView
 */
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

/**
 rowHeightForComponent

 @param pickerView pickerView
 @param component component
 @return CGFloat
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

/**
 UIPickerView

 @param pickerView UIPickerView
 @param row row
 @param component component
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

@end

/**
 SLAuthImageView
 */
@implementation SLAuthImageView {
    UIImageView *contenView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        //self.backgroundColor = [UIColor purpleColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        
        UIImageView *mask = [[UIImageView alloc] init];
        //mask.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        //mask.image = [UIImage imageNamed:@"auth_faild"];
        mask.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:mask];
        contenView = mask;
        
        self.type = SLAuthImageTypeNormal;
    }
    return self;
}
// superView need imp @selector(tapAction)
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(tapAction)) {
        return self.superview;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    CGFloat maskW = w * 0.8;
    CGFloat maskH = h * 0.8;
    contenView.bounds = CGRectMake(0, 0, maskW, maskH);
    contenView.center = CGPointMake(w / 2, h / 2);
}

/**
 type

 @param type SLAuthImageType
 */
- (void)setType:(SLAuthImageType)type {
    _type = type;
    self.userInteractionEnabled = NO;
    contenView.hidden = NO;
    switch (type) {
        case SLAuthImageTypeNormal:
            self.userInteractionEnabled = YES;
            contenView.hidden = YES;
            break;
            
        case SLAuthImageTypeAuthing:
            break;
            
        case SLAuthImageTypeSuccess:
            contenView.image = [UIImage imageNamed:@"auth_success"];
            break;
            
        case SLAuthImageTypeFailed:
            contenView.image = [UIImage imageNamed:@"auth_faild"];
            self.userInteractionEnabled = YES;
            break;
            
        default:
            break;
    }
}


@end

