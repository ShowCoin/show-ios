//
//  UIButton+ImageTitleSpacing.h
//  show gx
//
//  Created show gx on 17/5/25.
//  Copyright © 2017年 Show. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, SLButtonEdgeInsetsStyle) {
    SLButtonEdgeInsetsStyleTop, // image在上，label在下
    SLButtonEdgeInsetsStyleLeft, // image在左，label在右
    SLButtonEdgeInsetsStyleBottom, // image在下，label在上
    SLButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (ImageTitleSpacing)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(SLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
