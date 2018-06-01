//
//  SLSearchBar.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLSearchBar.h"
#import "SLSearchTextField.h"

NS_ASSUME_NONNULL_BEGIN
static const CGFloat SLSearchBarHeight = 44;
static const CGFloat SLTextFieldHeight = 28;
#define SLSearchBarMargin 15*Proportion375

@interface SLSearchBar ()<UITextFieldDelegate>
/** 1.输入框 */
@property (nonatomic, strong) SLSearchTextField *textField;
/** 2.取消按钮 */
@property (nonatomic, strong) UIButton *buttonCancel;
/** 3.搜索图标 */
@property (nonatomic, strong) UIImageView *imageIcon;
/** 4.中间视图 */
@property (nonatomic, strong) UIButton *buttonCenter;

@end
NS_ASSUME_NONNULL_END
@implementation SLSearchBar
#pragma mark - --- 1. init 视图初始化 ---
- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame searchHeight:(NSInteger)searchHeight backColor:(UIColor *)backColor hiddenCancelbutton:(NSInteger)hiddenCancelbutton
{
    if (self = [super initWithFrame:frame]) {
        _hiddenCancelbutton = hiddenCancelbutton;
        _searchHeight= searchHeight;
        _backColor = backColor;
        [self setupUI];
    }
    return self;
}
//- (void)awakeFromNib
//{
//    [self setupUI];
//}

- (void)setupUI{
    _placeholder = @"";
    _showsCancelButton =YES;
    _placeholderColor = kGrayTextColor;
    _leadingOrTailMargin = SLSearchBarMargin;

    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, SLSearchBarHeight);
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    [self addSubview:self.buttonCancel];
    [self addSubview:self.textField];
    [self addSubview:self.buttonCenter];

    //3.1修改布局
    self.buttonCancel.frame = CGRectMake(self.frame.size.width - 60, 0, 90, SLSearchBarHeight);
    self.textField.frame = CGRectMake(self.leadingOrTailMargin, _searchHeight>0?2:8, _hiddenCancelbutton?(self.width-self.leadingOrTailMargin*2): (self.buttonCancel.frame.origin.x-self.leadingOrTailMargin),_searchHeight>0?_searchHeight: SLTextFieldHeight);
   
    [self.textField setBackgroundColor:HexRGBAlpha(0xf4f4f4, 1)];
    [self.textField setTextColor:kDarkTextColor];
    [self.textField setTintColor:kthemeBlackColor];
    [_buttonCenter setTitleColor:_searchHeight>0?RGBACOLOR(255, 255, 255, .40):kThemeWhiteColor forState:UIControlStateNormal];
}


@end
