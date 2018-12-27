//
//  CXTextView.h
//  Wonderland
//
//  Created by chen on 2017/9/5.
//  Copyright © 2017年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE

@interface CXTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, copy) void(^textDidChangeBlock)(NSString *);

// default maxLength = 0 
@property (nonatomic, assign) NSInteger maxLength;

@end
