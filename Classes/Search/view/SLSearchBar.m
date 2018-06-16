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

- (id)initWithFrame:(CGRect)frame searchHeight:(NSInteger)searchHeight backColor:(UIColor *)backColor hiddenCancelbutton:(NSInteger)hiddenCancelbutton
{
    if (self = [super initWithFrame:frame]) {
        _hiddenCancelbutton = hiddenCancelbutton;
        _searchHeight= searchHeight;
        _backColor = backColor;
        [self setupUI];
    }
    return self;
}

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

#pragma mark - --- 2. delegate 视图委托 ---
#pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.canHideCancelButton) {
        CGRect frameButtonCenter = self.buttonCenter.frame;
        frameButtonCenter.origin.x = self.leadingOrTailMargin*2;
        [UIView animateWithDuration:0.3 animations:^{
            self.buttonCenter.frame = frameButtonCenter;
            if (self.showsCancelButton) {
                self.buttonCancel.frame = CGRectMake(self.frame.size.width - 60, 0, 60, SLSearchBarHeight);
                self.textField.frame = CGRectMake(self.leadingOrTailMargin, 8, self.buttonCancel.frame.origin.x-self.leadingOrTailMargin, SLTextFieldHeight);
            }
        } completion:^(BOOL finished) {
            [self.buttonCenter setHidden:YES];
            [self.imageIcon setHidden:NO];
            self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:self.placeholderColor}];
        }];
    } else {
        [self.buttonCenter setHidden:YES];
        [self.imageIcon setHidden:NO];
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:self.placeholderColor}];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)])
    {
        return [self.delegate searchBarShouldBeginEditing:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)])
    {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)])
    {
        return [self.delegate searchBarShouldEndEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length>0) {
        
    }
    else
    {
        [self.buttonCenter setHidden:NO];
        [self.imageIcon setHidden:YES];
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:self.placeholderColor}];
        self.textField.text = @"";
    }
    
    if (self.canHideCancelButton) {
        [UIView animateWithDuration:0.3 animations:^{
            if (self.showsCancelButton) {
                self.buttonCancel.frame = CGRectMake(self.frame.size.width, 0, 60, SLSearchBarHeight);
                self.textField.frame = CGRectMake(self.leadingOrTailMargin, 8, self.frame.size.width-self.leadingOrTailMargin*2, SLTextFieldHeight);
            }
            self.buttonCenter.center = self.textField.center;
        } completion:^(BOOL finished) {
            
        }];
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)])
    {
        [self.delegate searchBarTextDidEndEditing:self];
    }
    
}

-(void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField.text.length > 0) {
        [self.buttonCancel setHighlighted:YES];
    }else {
        [self.buttonCancel setHighlighted:NO];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [self.delegate searchBar:self textDidChange:textField.text];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)])
    {
        return [self.delegate searchBar:self shouldChangeTextInRange:range replacementText:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [self.delegate searchBar:self textDidChange:@""];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)])
    {
        [self.delegate searchBarSearchButtonClicked:self];
    }
    return YES;
}

#pragma mark - --- 3. event response 事件相应 ---
-(void)cancelButtonTouched
{
    self.textField.text = @"";
    [self.textField resignFirstResponder];
    [self.buttonCenter setHidden:NO];
    [self.imageIcon setHidden:YES];
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:self.placeholderColor}];
    if (self.canHideCancelButton) {
        [UIView animateWithDuration:0.3 animations:^{
            if (self.showsCancelButton) {
                self.buttonCancel.frame = CGRectMake(self.frame.size.width, 0, 60, SLSearchBarHeight);
                self.textField.frame = CGRectMake(self.leadingOrTailMargin, 8, self.frame.size.width-self.leadingOrTailMargin*2, SLTextFieldHeight);
            }
            self.buttonCenter.center = self.textField.center;
        } completion:^(BOOL finished) {
    
        }];
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)])
    {
        [self.delegate searchBarCancelButtonClicked:self];
    }
}

#pragma mark - --- 4. private methods 私有方法 ---
- (BOOL)becomeFirstResponder
{
    return [self.textField becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    return [self.textField resignFirstResponder];
}

#pragma mark - --- 5. setters 属性 ---
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self.buttonCenter setTitle:placeholder forState:UIControlStateNormal];
    [self.buttonCenter sizeToFit];
    [self.buttonCenter layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];

    self.buttonCenter.center = self.textField.center;
    // if buttonCenter.width > self.width
    // buttonCenter need reset frame
    self.buttonCenter.width += 20;
    self.buttonCenter.left = CGRectGetMinX(self.textField.frame) + 10;
}

- (void)setText:(NSString *)text
{
    self.textField.text = text?:@"";
    if (text.length > 0) {
        [self textFieldShouldBeginEditing:self.textField];
    }
}

- (void)setInputAccessoryView:(UIView *)inputAccessoryView
{
    _inputAccessoryView = inputAccessoryView;
    self.textField.inputAccessoryView = inputAccessoryView;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textField.textColor = textColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    NSAssert(_placeholder, @"Please set placeholder before setting placeholdercolor");
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:placeholderColor}];
    [self.buttonCenter setTitleColor:placeholderColor forState:UIControlStateNormal];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    self.textField.font = font;
    self.buttonCenter.titleLabel.font = font;
    [self.buttonCenter sizeToFit];
}

- (void)setCanHideCancelButton:(BOOL)canHideCancelButton
{
    _canHideCancelButton = canHideCancelButton;
    if (_canHideCancelButton) {
        self.buttonCancel.frame = CGRectMake(self.frame.size.width, 0, 60, SLSearchBarHeight);
        self.textField.frame = CGRectMake(self.leadingOrTailMargin, 8, self.frame.size.width-self.leadingOrTailMargin*2, SLTextFieldHeight);
        self.buttonCenter.center = self.textField.center;
    }
}

- (void)setLeadingOrTailMargin:(NSInteger)leadingOrTailMargin
{
    _leadingOrTailMargin = leadingOrTailMargin;
 
    if (_canHideCancelButton) {
        self.buttonCancel.frame = CGRectMake(self.frame.size.width, 0, 60, SLSearchBarHeight);
        self.textField.frame = CGRectMake(self.leadingOrTailMargin, 8, self.frame.size.width-self.leadingOrTailMargin*2, SLTextFieldHeight);
        self.buttonCenter.center = self.textField.center;
    }
}

#pragma mark - --- 6. getters 属性 —

- (NSString *)text
{
    return self.textField.text;
}

- (SLSearchTextField *)textField
{
    if (!_textField) {
        SLSearchTextField *textField = [[SLSearchTextField alloc] initWithFrame:CGRectMake(self.leadingOrTailMargin, 8, self.frame.size.width-self.leadingOrTailMargin*2 - (_showsCancelButton?0:_buttonCancel.width), SLTextFieldHeight)];
        textField.delegate = self;
        textField.borderStyle = UITextBorderStyleNone;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.returnKeyType = UIReturnKeySearch;
        textField.enablesReturnKeyAutomatically = YES;
        textField.font = [UIFont systemFontOfSize:14.0f];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField addTarget:self
                      action:@selector(textFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        textField.borderStyle=UITextBorderStyleNone;
        [textField.layer setCornerRadius:4];
        [textField setLeftViewMode:UITextFieldViewModeAlways];
        textField.leftView = self.imageIcon;
        textField.textColor=kThemeWhiteColor;
        textField.tintColor=kThemeWhiteColor;

        _textField = textField;
        
    }
    return _textField;
}

- (UIButton *)buttonCancel
{
    if (!_buttonCancel) {
        UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonCancel.frame = CGRectMake(self.frame.size.width, 0, 60, SLSearchBarHeight);
        buttonCancel.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [buttonCancel addTarget:self
                         action:@selector(cancelButtonTouched)
               forControlEvents:UIControlEventTouchUpInside];
        [buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
        [buttonCancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [buttonCancel setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        buttonCancel.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin;
        buttonCancel.hidden = _hiddenCancelbutton?YES:NO;
        _buttonCancel = buttonCancel;
    }
    return _buttonCancel;
}

- (UIButton *)buttonCenter
{
    if (!_buttonCenter) {
        UIButton *buttonCenter = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonCenter setImage:[UIImage imageNamed:@"icon_STSearchBar"] forState:UIControlStateNormal];
        [buttonCenter setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [buttonCenter.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [buttonCenter setEnabled:NO];
        buttonCenter.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [buttonCenter sizeToFit];
        _buttonCenter = buttonCenter;
    }
    return _buttonCenter;
}

- (UIImageView *)imageIcon
{
    if (!_imageIcon) {
        UIImageView *imageIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_STSearchBar"]];
        [imageIcon setHidden:YES];
        _imageIcon = imageIcon;
    }
    return _imageIcon;
}

@end
