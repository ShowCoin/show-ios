//
//  SLIdCardVIew.m
//  test
//
//  Created by chenyh on 2018/7/2.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLAuthenticationView.h"

static CGFloat const kMargin = 15;

@interface SLAuthenticationView ()

@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, weak) UILabel *detialLabel;
@property (nonatomic, weak) SLAuthImageView *imageView;
@property (nonatomic, weak) UIImageView *placeholderView;
@property (nonatomic, weak) UILabel *errorLabel;
@property (nonatomic, copy) NSString *placeholder;

@end

@implementation SLAuthenticationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = SLNormalColor;
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    self.textLabel = label;
    
    label = [[UILabel alloc] init];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    [self addSubview:label];
    self.detialLabel = label;
    
    SLAuthImageView *imageView = [[SLAuthImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    //imageView2.backgroundColor = [UIColor purpleColor];
    [self addSubview:imageView2];
    self.placeholderView = imageView2;
    
    label = [[UILabel alloc] init];
    label.textColor = [UIColor redColor];//
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    label.hidden = YES;
    [self addSubview:label];
    self.errorLabel = label;
}

@end


