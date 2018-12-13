
//
//  UIImage+Additional.m
//  
//
//  Created by Bob on 15/4/10.
//  Copyright (c) 2015年 家伟 李. All rights reserved.
//

#import "UIImage+Additional.h"
#import <Accelerate/Accelerate.h>

CGRect swapWidthAndHeight(CGRect rect)
{
    CGFloat  swap = rect.size.width;
    
    rect.size.width  = rect.size.height;
    rect.size.height = swap;
    
    return rect;
}

@implementation UIImage (Additional)



@end
