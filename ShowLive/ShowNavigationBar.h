//
//  ShowNavigationBar.h
//
//  Created by  JokeSmileZhang on 17/10/30.
//  Copyright © 2017年 www.evrental.cn All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  导航Bar的样式 枚举
 */
typedef NS_ENUM(NSInteger, NavigationBarType){
    /**
     *  显示 左侧View
     */
    NavigationBarLeft   = 1<<1,
    /**
     *  显示 中间Title
     */
    NavigationBarMiddle = 1<<2,
    /**
     *  显示 右侧View
     */
    NavigationBarRight  = 1<<3,
    /**
     *  显示 全部View
     */
    NavigationBarAll    = 1<<4,
    /**
     *  隐藏 全部View
     */
    NavigationBarNone   = 1<<5
    
};

typedef NS_ENUM(NSInteger, NavigationLeftBarType){
    /**
     *  显示 默认的返回按钮
     */
    NavigationBarLeftNone   = 1,
    NavigationBarLeftDefault   = 2,
};

typedef NS_ENUM(NSInteger, NavigationRightBarType){
    /**
     *  显示 默认的返回按钮
     */
    NavigationBarRightNone   = 1,
    NavigationBarRightDefault   = 2,
    
};

typedef NS_ENUM(NSInteger, NavigationLineType){
    /**
     *  显示 线的样式
     */
    NavigationLineNone   = 1,
    NavigationLineDefault   = 2,
};
typedef NS_ENUM(NSInteger, NavigationColorType){
    /**
     *  显示 线的样式
     */
    NavigationColorDefault   = 1,
    NavigationColorBlack   = 2,
    NavigationColorwihte = 3,
    NavigationColorGray = 4
};
@protocol ShowNavigationBarDelegate <NSObject>

@optional
- (void)clickLeftButton:(UIButton *)sender;

- (void)clickRightButton:(UIButton *)sender;

@end


@interface ShowNavigationBar : UIView

@property (strong, nonatomic, readwrite)  UIView *leftView;
@property (strong, nonatomic, readwrite)  UIView *middleView;
@property (strong, nonatomic, readwrite)  UIView *rightView;
@property (weak,nonatomic) id<ShowNavigationBarDelegate> delegate;

+ (instancetype)createNavigationBar;


/**
 *  设置 navigation 的 title
 */
- (void)setNavigationTitle:(NSString *) title;
/**
 *  设置 navigation 的 color
 */
- (void)setNavigationColor:(NavigationColorType )type;

/**
 *  设置 navigation 的 左侧Icon
 */
- (void)setLeftIconImage:(UIImage *) image forState:(UIControlState) state;

/**
 *  设置 navigation 的 右侧Icon
 */
- (void)setRightIconImage:(UIImage *) image forState:(UIControlState) state;

- (void)setRightTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font;
- (void)setLeftTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font;
- (void)setRightTitle:(NSString *)title;
/************************************************************/

//*    以下方法适用于  默认的 样式无法满足需求，需要自定义view的时候
//*
//*

/************************************************************/


/**
 *  设置左侧 view 的width （默认是 44）
 */
- (void)setLeftWidth:(CGFloat) width;
/**
 *  设置右侧 view 的width （默认是 44）
 */
- (void)setRightWidth:(CGFloat) width;

/**
 *  设置自定的  left View  (view需要支持autolayout 布局)
 */
- (void)setNavigationLeftView:(UIView *)customerView;
/**
 *  设置自定的  right View  (view需要支持autolayout 布局)
 */
- (void)setNavigationRightView:(UIView *)customerView;
/**
 *  设置自定的  middle View  (view需要支持autolayout 布局)
 */
- (void)setNavigationMiddleView:(UIView *)customerView;

/**
 * 隐藏Bar
 */
- (void)setNavigationBarHidden:(BOOL)hidden animted:(BOOL)animted;

/**
 *  隐藏右边的按钮
 */
- (void)setRightNavigationBarEnabled:(BOOL)enabled ;

/**
 *  是否隐藏
 */
- (void)setNavigationLineHidden:(BOOL)hidden ;
/**
 *  设置 NavigationLine 的样式
 */
- (void)setNavigationLineType:(NavigationLineType )type ;

/**
 *  设置 NavigationBar 的样式
 */
- (void)setNavigationBarStyle:(NavigationBarType)barStyle;

/**
 *  设置 NavigationLeftBar 的样式
 */
- (void)setNavigationLeftBarStyle:(NavigationLeftBarType)barStyle;

/**
 *  设置 NavigationRightBar 的样式
 */
- (void)setNavigationRightStyle:(NavigationRightBarType)barStyle;


@end

