/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
**/

#import <UIKit/UIKit.h>

@interface UIImage (resize)

-(UIImage*)imageThatFits:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

@end
