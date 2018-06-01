//
//  SLSearchBar.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class SLSearchBar;
@protocol SLSearchBarDelegate <UIBarPositioningDelegate>

@optional
-(BOOL)searchBarShouldBeginEditing:(SLSearchBar *)searchBar;
- (void)searchBarTextDidBeginEditing:(SLSearchBar *)searchBar;
- (BOOL)searchBarShouldEndEditing:(SLSearchBar *)searchBar;
- (void)searchBarTextDidEndEditing:(SLSearchBar *)searchBar;
- (void)searchBar:(SLSearchBar *)searchBar textDidChange:(NSString *)searchText;
- (BOOL)searchBar:(SLSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

- (void)searchBarSearchButtonClicked:(SLSearchBar *)searchBar;
- (void)searchBarCancelButtonClicked:(SLSearchBar *)searchBar;
// called when cancel button pressed
@end

@interface SLSearchBar : UIView
@property(nullable,nonatomic,weak) id<SLSearchBarDelegate> delegate;
@property(nullable,nonatomic,copy) NSString  *text;
@property(nullable,nonatomic,copy) NSString  *placeholder;
@property(nonatomic) BOOL  showsCancelButton;
@property(nullable,nonatomic,strong) UIColor *textColor;
@property(nullable,nonatomic,strong) UIFont  *font;
@property(nullable,nonatomic,strong) UIColor *placeholderColor;

/* Allow placement of an input accessory view to the keyboard for the search bar
 */
@property (nullable,nonatomic,readwrite,strong) UIView *inputAccessoryView;
@property (assign, nonatomic) BOOL canHideCancelButton;// 是否可以隐藏取消按钮 默认NO,该模式下是icon中间布局
@property (assign, nonatomic) NSInteger leadingOrTailMargin; // textfiled距离左边、右边的距离 默认15
@property (assign, nonatomic) NSInteger searchHeight; // textfiled高
@property (assign, nonatomic) NSInteger hiddenCancelbutton; // 隐藏取消键
@property (strong, nonatomic,nullable) UIColor * backColor; // 颜色

- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;
- (void)cancelButtonTouched;
-(id)initWithFrame:(CGRect)frame searchHeight:(NSInteger)searchHeight backColor:(UIColor *)backColor hiddenCancelbutton:(NSInteger)hiddenCancelbutton;
@end
NS_ASSUME_NONNULL_END
