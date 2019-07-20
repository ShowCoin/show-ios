//
//  UIBarButtonItem+Extension.h
//  show
//
//  Created by show on 15/8/27.
//  Copyright (c) 2015年 show. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
