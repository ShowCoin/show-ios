//
//  SLVisualEffectView.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/10.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLVisualEffectView.h"

@implementation SLVisualEffectView


+ (instancetype)creatForstedClassViewFrame:(CGRect)frame
                              effectStytle:(UIBlurEffectStyle)stytle
                               effectColor:(UIColor *)effectColor
{
    
    return  [[self alloc]initWithFrame:(CGRect)frame
                          effectStytle:(UIBlurEffectStyle)stytle
                           effectColor:(UIColor *)effectColor];
}


- (instancetype)initWithFrame:(CGRect)frame
                 effectStytle:(UIBlurEffectStyle)stytle
                  effectColor:(UIColor *)effectColor

{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:stytle];
        
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
        effectView.frame = self.bounds;
        effectView.backgroundColor = effectColor;
        
        [self addSubview:effectView];
        
    }
    
    return self;
    
}
@end
