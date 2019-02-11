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
-(BOOL)searchBarShouldBeginEditing:(SLSearchBar *)searchBar;                      // return NO to not become first responder
- (void)searchBarTextDidBeginEditing:(SLSearchBar *)searchBar;                     // called when text starts editing
- (BOOL)searchBarShouldEndEditing:(SLSearchBar *)searchBar;                        // return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(SLSearchBar *)searchBar;                       // called when text ends editing
- (void)searchBar:(SLSearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
- (BOOL)searchBar:(SLSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; // called before text changes

- (void)searchBarSearchButtonClicked:(SLSearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)searchBarCancelButtonClicked:(SLSearchBar *)searchBar;                     // called when cancel button pressed
// called when cancel button pressed
@end

@interface SLSearchBar : UIView
//搜索代理
@property(nullable,nonatomic,weak) id<SLSearchBarDelegate> delegate; // default is nil. weak reference
//文字
@property(nullable,nonatomic,copy) NSString  *text;                  // current/starting search text
//站位文字
@property(nullable,nonatomic,copy) NSString  *placeholder;           // default is nil. string is drawn 70% gray
//显示取消按钮
@property(nonatomic) BOOL  showsCancelButton;
//文字颜色
@property(nullable,nonatomic,strong) UIColor *textColor;
//文字字体
@property(nullable,nonatomic,strong) UIFont  *font;
//占位文字
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
