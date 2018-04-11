//
//  ShowHomeMiddleCell.m
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHomeMiddleCell.h"
#define cellWith        (KScreenWidth - 1)/2

@implementation ShowHomeMiddleCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.coverImage];
    }
    return self;
}
-(YYAnimatedImageView *)coverImage
{
    if (!_coverImage) {
        _coverImage = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0,cellWith ,cellWith/10*16)];
        _coverImage.contentMode = UIViewContentModeScaleToFill;
        //        [_coverImage yy_setImageWithURL:[NSURL URLWithString:@"http://www.131mmw.com/uploads/allimg/180407/1-1P40G04248.jpg"] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
//        [_coverImage sd_setImageWithURL:[NSURL URLWithString:@"http://www.131mmw.com/uploads/allimg/180407/1-1P40G04248.jpg"]];
        [_coverImage setImage:[UIImage imageNamed:@"login_bg"]];
        _coverImage.backgroundColor = [UIColor blackColor];
        _coverImage.clipsToBounds = YES;
    }
    return _coverImage;
}
@end
