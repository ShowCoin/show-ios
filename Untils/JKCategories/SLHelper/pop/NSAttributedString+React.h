//
//  NSAttributedString+React.h
//  show gx
//
//  Created by show gx on 17/3/20.
//  Copyright © 2017年 show gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (React)
-(CGFloat)getWidthWithAttributeString:(NSMutableAttributedString*)attributeString labelheight:(CGFloat)height;
-(CGFloat)getHeightWithAttributeString:(NSMutableAttributedString*)attributeString labelwidth:(CGFloat)width;
-(CGFloat)getWidthWithFont:(UIFont *)font height:(CGFloat)height;
-(CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width;
@end
