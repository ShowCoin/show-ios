//
//  UITextView+PlaceHolder.h
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UITextView (JKPlaceHolder) <UITextViewDelegate>

//类似于textfeild 的placeholder
@property (nonatomic, strong) UITextView *jk_placeHolderTextView;
- (void)jk_addPlaceHolder:(NSString *)placeHolder;
@end
