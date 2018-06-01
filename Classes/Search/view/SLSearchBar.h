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
@property(nullable,nonatomic,weak) id<SLSearchBarDelegate> delegate; // default is nil. weak reference
@property(nullable,nonatomic,copy) NSString  *text;                  // current/starting search text
@property(nullable,nonatomic,copy) NSString  *placeholder;           // default is nil. string is drawn 70% gray
@property(nonatomic) BOOL  showsCancelButton;                        // default is yes
@property(nullable,nonatomic,strong) UIColor *textColor;             // default is nil. use opaque black
@property(nullable,nonatomic,strong) UIFont  *font;                  // default is nil. use system font 12 pt
@property(nullable,nonatomic,strong) UIColor *placeholderColor;      // default is drawn 70% gray

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
