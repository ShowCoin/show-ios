//
//  UIView+build.m
//  Secret
//
//  Created by Tim on 14-3-5.
//  Copyright (c) 2014年 Wk. All rights reserved.

#import "UIView+build.h" 

@implementation UIView(build)

-(UILabel*)buildLabel:(NSString*)text withFrame:(CGRect)frame withFont:(UIFont*)font withTextColor:(UIColor*)color withTextAlign:(NSTextAlignment)align{
    UILabel* lblTitle=[[UILabel alloc] initWithFrame:frame];
    lblTitle.textAlignment=align;
    [lblTitle setBackgroundColor:[UIColor clearColor]];
    [lblTitle setFont:font];
    [lblTitle setTextColor:color];
    lblTitle.text=text;
    lblTitle.numberOfLines=0;
    
    [self addSubview:lblTitle];
    return lblTitle;
}
-(UIImageView*)buildImageView:(NSString*)imageName withFrame:(CGRect)frame{
    UIImageView* imgv=[[UIImageView alloc] initWithFrame:frame];
    [imgv setImage:[UIImage imageNamed:imageName]];
    [self addSubview:imgv];
    return imgv;
}
-(UIView*)buildView:(UIColor*)bgColor withFrame:(CGRect)frame{
    UIView* view=[[UIView alloc] initWithFrame:frame];
    [view setBackgroundColor:bgColor];
    [self addSubview:view];
    return view;
}
-(UITextField*)buildTextField:(UIColor*)bgColor withFrame:(CGRect)frame withPlaceholder:(NSString*)placeholder withTextColor:(UIColor*)textColor withFont:(UIFont*)font withReturnKeyType:(UIReturnKeyType)returnKeyType withKeyboardType:(UIKeyboardType)keyboardType{
    UITextField* txt=[[UITextField alloc] initWithFrame:frame];
    [self addSubview:txt];
    [txt setPlaceholder:placeholder];
    [txt setReturnKeyType:returnKeyType];
    [txt setKeyboardType:keyboardType];
    [txt setTextColor:textColor];
    [txt setFont:font];
    [txt setBorderStyle:UITextBorderStyleNone];
    [txt setTextAlignment:NSTextAlignmentLeft];
    [txt setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter]; 
    return txt;
}

-(UIButton*)buildButton:(NSString*)title withFrame:(CGRect)frame withTitleColor:(UIColor*)color withTarget:(id)target withAction:(SEL)action withBoderWidth:(CGFloat)boderWidth withBoderColor:(UIColor*)boderColor withBackgroundColor:(UIColor*)bgColor withSelectedBgColor:(UIColor*)selectedBgColor{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:bgColor];
    if (selectedBgColor) {
        UIImage* selectedImage=[self createImageWithColor:selectedBgColor]; //iphone4上性能不行
        
        [btn setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
        [btn setTitleColor:bgColor forState:UIControlStateHighlighted];
    }
    if (boderWidth>0) {
        [btn.layer setBorderColor:boderColor.CGColor];
        [btn.layer setBorderWidth:boderWidth];
    }
    [btn.layer setCornerRadius:frame.size.height/2];
    [btn.layer setMasksToBounds:YES];
    return btn;
}
- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
-(UIView*)processingDefault
{
    UIView* bgView=[self buildView:[UIColor clearColor] withFrame:KScreenRect];
    bgView.tag=1098991;
    
    CGFloat originY=kMainScreenHeight/2-45;
    if (originY>(kMainScreenHeight-320)) {
        originY=kMainScreenHeight-320;
    }
    UIView* bg=[[UIView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-60, originY, 120, 90)];
    UIActivityIndicatorView* av=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [av setFrame:CGRectMake(40, 12.5, 40, 40)];
    [bg addSubview:av];
    [av startAnimating];
    dispatch_safe_main(^{
        [bgView addSubview:bg]; 
        [bg setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.85]];
        [bg.layer setCornerRadius:10.0];
        bg.layer.masksToBounds=YES;
        
        UILabel* lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 60, bg.frame.size.width, 20)];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [bg addSubview:lbl];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        lbl.text=@"正在处理中...";
        lbl.font=[UIFont systemFontOfSize:15];
        lbl.textColor=[UIColor whiteColor];
    });
    return bg;
}
-(UIView*)processing:(NSString*)tips
{
    UIView* bgView=[self buildView:HexRGBAlpha(0xffffff, 0.6) withFrame:KScreenRect];
    bgView.tag=1098991;
   
    CGSize size = CGSizeZero;
        size = [tips boundingRectWithSize:CGSizeMake(266, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    
    CGFloat originY=kMainScreenHeight/2-size.height/2-10;
    if (originY>(kMainScreenHeight-300)) {
        originY=kMainScreenHeight-300;
    }
    UIView* bg=[[UIView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-size.width/2-27, originY, size.width+24+30, size.height+20)];
    UIActivityIndicatorView* av=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [av setFrame:CGRectMake(15, size.height/2, 20, 20)];
    [bg addSubview:av];
    [av startAnimating];
    dispatch_safe_main(^{
        [bgView addSubview:bg];
        [bg setBackgroundColor:[UIColor blackColor]];
        [bg.layer setCornerRadius:5.0];
        bg.layer.masksToBounds=YES;
        
        UILabel* lbl=[[UILabel alloc] initWithFrame:CGRectMake(45, 10, size.width, size.height)];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [bg addSubview:lbl];
        lbl.text=tips;
        lbl.font=[UIFont systemFontOfSize:15];
        lbl.textColor=[UIColor whiteColor];
    });
    return bg;
}
-(void)fadeProcessingView{
    dispatch_safe_main(^{
        UIView* v=[self viewWithTag:1098991];
        if (v) {
            for (UIView* vv in v.subviews) {
                [vv removeFromSuperview];
            }
            [v removeFromSuperview];
            v=nil;
        }
    });
}
-(UIView*)poptips:(NSString*)tips
{
    CGSize size = CGSizeZero;
    
        size = [tips boundingRectWithSize:CGSizeMake(266, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    
    CGFloat originY=kMainScreenHeight/2-size.height/2-10;
    if (originY>(kMainScreenHeight-300)) {
        originY=kMainScreenHeight-300;
    }
    UIView* bg=[[UIView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-size.width/2-12, originY, size.width+24, size.height+20)];
    dispatch_safe_main(^{
        [self addSubview:bg];
        [bg setBackgroundColor:[UIColor blackColor]];
        [bg.layer setCornerRadius:5.0];
        bg.layer.masksToBounds=YES;
        
        UILabel* lbl=[[UILabel alloc] initWithFrame:CGRectMake(15, 10, size.width, size.height)];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [bg addSubview:lbl];
        lbl.text=tips;
        lbl.numberOfLines=0;
        lbl.lineBreakMode = NSLineBreakByWordWrapping;
        lbl.font=[UIFont systemFontOfSize:15];
        lbl.textColor=[UIColor whiteColor];
        [self performSelector:@selector(fadetips:) withObject:bg afterDelay:2];
    });
    return bg;
}
-(void)fadetips:(UIView*)v
{
    if (v) {
        for (UIView* vv in v.subviews) {
            [vv removeFromSuperview];
        }
        [v removeFromSuperview];
        v=nil;
    }
}
@end
