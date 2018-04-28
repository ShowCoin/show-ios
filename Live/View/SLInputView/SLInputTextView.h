//
//  SLInputTextView.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/12.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLInputTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIFont *placeholdFont;

-(void)textChanged:(NSNotification*)notification;
/*
 更改字体大小
 */
-(void)changePlaceHolderFontSize:(CGFloat)size;


@end
