//
//  LPCoverView.m
//  Edu
//
//  Created by chenyh on 2018/9/19.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "LPCoverView.h"
#import "SLHeadPortrait.h"
#import "SLShadowLabel.h"
#import "LPIconView.h"

CGFloat LPGetLabelWidth(UILabel *label) {
    return [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, label.font.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : label.font} context:nil].size.width;
}

static CGFloat const kLPUserViewWH = 17;

@interface LPCoverView () 

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *preCoverButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) LPIconView *showView;
@property (nonatomic, strong) LPIconView *ratioView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) SLHeadPortrait  *userView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation LPCoverView {
    BOOL isScale;
    CGRect  originRect_;
    CGRect  beginRect_;
    UIView *beginView_;
}

@end
