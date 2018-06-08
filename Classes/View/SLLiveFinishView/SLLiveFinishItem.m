//
//  SLLiveFinishItem.m
//  ShowLive
//
//  Created by gongxin on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveFinishItem.h"

@interface SLLiveFinishItem ()

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *valueLabel;

@end

@implementation SLLiveFinishItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

-(void)setValue:(NSString *)value
{
    
}
@end
