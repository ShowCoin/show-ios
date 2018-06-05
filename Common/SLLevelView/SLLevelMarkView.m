//
//  SLLevelView.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/25.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLevelMarkView.h"
@interface SLLevelMarkView()
@property (nonatomic , strong) UIButton * levelView;
@end
@implementation SLLevelMarkView
- (id)initWithFrame:(CGRect)frame withType:(LevelType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _type = type;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.levelView];
        [self cornerRadiusStyle];

    }
    return self;
}
- (UIButton *)levelView
{
    if (!_levelView) {
        _levelView = [UIButton buttonWithType:UIButtonTypeCustom];
        _levelView.frame = CGRectMake(0, 0, self.width, self.height);
        [_levelView cornerRadiusStyle];

    }
    return _levelView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
