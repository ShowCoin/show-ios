//
//  UIImageView+Category.m
//  showgx
//
//  Created by show on 16/6/21.
//  Copyright © 2016年 Show. All rights reserved.
//

#import "UIImageView+Category.h"
#import "UIImage+Compress.h"
#import "AppDelegate.h"
#import <ImageIO/ImageIO.h>
@implementation UIImageView (Category)

+(UIImageView*)blurImageWithView:(UIView *)view
{
    
    UIImage * screenImage=[view convertViewToImage];
    //将图片模糊
    UIImage * blurImage=[screenImage blurredImageWithRadius:25 iterations:1 tintColor:[UIColor blackColor]];
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.userInteractionEnabled=YES;
    imageView.image=blurImage;
    
    UIView * blackView=[[UIView alloc]initWithFrame:imageView.bounds];
    blackView.backgroundColor=[UIColor blackColor];
    blackView.alpha=0.2;
    [imageView addSubview:blackView];
    
    
    return imageView;
    
}

@end
