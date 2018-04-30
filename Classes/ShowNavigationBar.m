//
//  EVNavigationBar.m
//
//  Created by JokeSmilzhang on 18/3/30.
//  Copyright © 2018年 vning Show. All rights reserved.
//

#import "ShowNavigationBar.h"

@interface ShowNavigationBar(){
    UIButton   *_leftBtn;
    UIButton   *_rightBtn;
    UILabel    *_titleLabel;
    UIImageView*_titleImageView ;
}

@property (weak, nonatomic)  NSLayoutConstraint *leftViewWidth;
@property (weak, nonatomic)  NSLayoutConstraint *rightViewWidth;
@property (strong, nonatomic)UIView *linView;

@end

@implementation ShowNavigationBar

+ (instancetype)show_createNavigationBar
{
    ShowNavigationBar *bar =  [[self alloc]init];
    
    /**
     *  设置默认样式
     */
    [bar setDefaultStyle];
    bar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KNaviBarHeight);
    bar.backgroundColor = kThemeYellowColor;
    return bar;
}

- (void)show_layout
{
    CGFloat height = 0;
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        height = 44;
    } else {
        height = 64;
    }
}
/**
 *
 *
 *  默认的 样式：
    
    1.左侧是一个   UIButton按钮
    2.中间是一个   UILabel
    3.右侧是一个   UIButton按钮
 */
- (void)show_setDefaultStyle {

    _leftView = [[UIView alloc]init];
    [self addSubview:_leftView];
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20+KTabbarSafeBottomMargin );
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.equalTo(self).with.offset(6);
    }];
    _rightView = [[UIView alloc]init];
    [self addSubview:_rightView];
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20+KTabbarSafeBottomMargin );
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.right.equalTo(self).with.offset(-6);
    }];
    
    _middleView = [[UIView alloc]init];
    [self addSubview:_middleView];
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20+KTabbarSafeBottomMargin );
        make.centerX.equalTo(self);
        make.height.equalTo(@44);
        make.width.equalTo(self).with.offset(-88);
    }];
         
    _linView = [[UIView alloc]init];
    [self addSubview:_linView];
    [_linView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self);
        make.height.equalTo(@0.5);
    }];
    /**
     *
     *  左侧默认是返回按钮的icon
     */
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftView addSubview:_leftBtn];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.leftView);
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
    }];
    /**
     *
     *  右侧默认没有 icon
     */
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.rightView);
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
    }];
  
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:18.0f];
    _titleLabel.text = @"";
    //设置文字过长时的显示格式
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;//截去中间  abc..xyz
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.middleView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.middleView);
    }];
    
    
    _titleImageView = [UIImageView new] ;
    _titleImageView.backgroundColor = [UIColor clearColor] ;
    _titleImageView.contentMode = UIViewContentModeCenter ;
    [self.middleView addSubview:_titleImageView];
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.middleView);
    }];
    
    [self setNavigationLeftBarStyle:NavigationBarLeftDefault];
}

- (void)show_setNavigationTitle:(NSString *) title{
    if (_titleLabel) {
        _titleLabel.text = title;

    }
}
- (void)show_setLeftIconImage:(UIImage *) image forState:(UIControlState) state{
    if (_leftBtn) {
        [_leftBtn setImage:image forState:state];
    }
}
- (void)show_setRightIconImage:(UIImage *) image forState:(UIControlState) state{
    if (_rightBtn) {
        [_rightBtn setImage:image forState:state];
        [_rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0f, -10.0f, 0.0f, 0.0f)];
    }
}

- (void)show_setRightTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font
{
  if (_rightBtn) {
    [_rightBtn setTitle:title forState:UIControlStateNormal];
    [_rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -25.0f, 0.0f, 0.0f)];
    [_rightBtn  setTitleColor:color forState:UIControlStateNormal];
    [_rightBtn.titleLabel setFont:font];
  }
}
- (void)show_setRightTitle:(NSString *)title
{
    [self setRightTitle:title titleColor:BlackColor font:[UIFont systemFontOfSize:15.0f]];
}
- (void)setLeftTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font
{
  if (_leftBtn) {
    [_leftBtn setTitle:title forState:UIControlStateNormal];
    [_leftBtn  setTitleColor:color forState:UIControlStateNormal];
    [_leftBtn.titleLabel setFont:font];
  }
}


- (void)show_setNavigationMiddleView:(UIView *)customerView {
    /**
     *  删除 middle View 下面的所有子view
     */
    [self.middleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(44, 280));
    }];
    
    [self.middleView addSubview:customerView];
    [customerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.middleView);
        make.size.mas_equalTo(customerView.frame.size);
    }];
}
- (void)show_setNavigationLeftView:(UIView *)customerView {
    /**
     *  删除 left View 下面的所有子view
     */
    [self.leftView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addSubview:self.leftView];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
}
- (void)show_setNavigationRightView:(UIView *)customerView {
    /**
     *  删除 right View 下面的所有子view
     */
    [self.rightView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
}

- (void)show_setLeftWidth:(CGFloat) width {
    self.leftViewWidth.constant = width;
}
- (void)setRightWidth:(CGFloat) width {
    self.rightViewWidth.constant = width;
}


#pragma mark - 左侧 & 右侧 的点击事件

- (void)show_clickLeftButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickLeftButton:)]) {
        [self.delegate clickLeftButton:sender];
    }
}
- (void)show_clickRightButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickRightButton:)]) {
        [self.delegate clickRightButton:sender];
    }
}


#pragma mark - 设置样式
/**
 *  设置 navigation 的 color
 */
- (void)show_setNavigationColor:(NavigationColorType )type;
{
    NSInteger style = type;
    
    switch (style) {
        case NavigationColorDefault:
            _titleLabel.textColor = [UIColor whiteColor];
            break;
        case NavigationColorBlack:
            self.backgroundColor = kthemeBlackColor;
            _linView.backgroundColor = HexRGBAlpha(0xf7f7f7, .3);
            _titleLabel.textColor = [UIColor whiteColor];
            [self setLeftIconImage:[UIImage imageNamed:@"account_navBack"] forState:UIControlStateNormal];
            break;
        case NavigationColorwihte:
            _titleLabel.textColor = kthemeBlackColor;
            self.backgroundColor = kThemeWhiteColor;
            [self setLeftIconImage:[UIImage imageNamed:@"account_navBack_black"] forState:UIControlStateNormal];
            _linView.backgroundColor = kSeparationColor;

            break;
        case NavigationColorGray:
            self.backgroundColor = kGrayWithf4f4f4;
            _titleLabel.textColor = kthemeBlackColor;
            [self setLeftIconImage:[UIImage imageNamed:@"account_navBack_black"] forState:UIControlStateNormal];
            _linView.backgroundColor = kSeparationColor;

            break;
        case NavigationColorClear:
            self.backgroundColor = [UIColor clearColor];
            _titleLabel.textColor = kThemeWhiteColor;
            [self setLeftIconImage:[UIImage imageNamed:@"account_navBack"] forState:UIControlStateNormal];
            _linView.backgroundColor = [UIColor clearColor];
            
            break;
            
        default:
            break;
    }
}
- (void)show_setNavigationBarStyle:(NavigationBarType)barStyle
{
    self.leftView.hidden = YES;
    self.middleView.hidden = YES;
    self.rightView.hidden = YES;

    NSInteger style = barStyle;

    switch (style) {
        case NavigationBarLeft:
            [self.leftView setHidden:NO];
            break;
        case NavigationBarMiddle:
            [self.middleView setHidden:NO];
            break;
        case NavigationBarRight:
            [self.rightView setHidden:NO];
            break;
        case (NavigationBarLeft|NavigationBarMiddle):
            [self.leftView setHidden:NO];
            [self.middleView setHidden:NO];
            break;
        case (NavigationBarLeft|NavigationBarRight):
            [self.leftView setHidden:NO];
            [self.rightView setHidden:NO];
            break;
        case (NavigationBarMiddle|NavigationBarRight):
            [self.middleView setHidden:NO];
            [self.rightView setHidden:NO];
            break;
        case (NavigationBarLeft|NavigationBarRight|NavigationBarMiddle):
            [self.leftView setHidden:NO];
            [self.middleView setHidden:NO];
            [self.rightView setHidden:NO];
            break;
        case (NavigationBarAll):
            [self.leftView setHidden:NO];
            [self.middleView setHidden:NO];
            [self.rightView setHidden:NO];
            break;
        case (NavigationBarNone):
            [self.leftView setHidden:YES];
            [self.middleView setHidden:YES];
            [self.rightView setHidden:YES];
            break;
        default:
            break;
    }
}
- (void)show_setNavigationLeftBarStyle:(NavigationLeftBarType)barStyle{
    
    UIImage *image = nil ;
    switch (barStyle) {
        case NavigationBarLeftNone:
            _leftBtn.hidden = YES ;
            break;
        case NavigationBarLeftDefault:
            image = [UIImage imageNamed:@"account_navBack"];
            break;
        default:
            image = nil ;
            break;
    }
    [_leftBtn setImage:image forState:UIControlStateNormal];
    [_leftBtn setImage:image forState:UIControlStateHighlighted];
}

- (void)show_setNavigationRightStyle:(NavigationRightBarType)barStyle{
    UIImage *image = nil ;
    switch (barStyle) {
        case NavigationBarLeftNone:
            _rightBtn.hidden = YES ;
            break;
        default:
            image = nil ;
            break;
    }
    [_rightBtn setImage:image forState:UIControlStateNormal];
    [_rightBtn setImage:image forState:UIControlStateHighlighted];
}

- (void)show_setNavigationBarHidden:(BOOL)hidden animted:(BOOL)animted
{
    NSTimeInterval interval = animted?0.5:0.0;
    if (hidden) {
        CGFloat transh = CGRectGetHeight(self.frame);
        [UIView animateWithDuration:interval animations:^{
            self.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0.0f, -transh);
        }];
    }else{
        [UIView animateWithDuration:interval animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    }
}
- (void)show_setRightNavigationBarEnabled:(BOOL)enabled{
    [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    _rightBtn.enabled = enabled ;
}

- (void)show_setNavigationLineHidden:(BOOL)hidden{
    _linView.hidden = hidden ;
}

- (void)show_setNavigationLineType:(NavigationLineType )type{
    switch (type) {
        case NavigationLineNone:
            _linView.hidden = YES ;
            break;
        case NavigationLineDefault:
            _linView.hidden = NO ;
            _linView.backgroundColor = HexRGBAlpha(0xc09274, 1) ;
            break;
        default:
            break;
    }
}

- (void)show_setNavigationLineColor:(UIColor *)color{
    if(_linView.hidden){
        return ;
    }
    _linView.backgroundColor = color ;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
