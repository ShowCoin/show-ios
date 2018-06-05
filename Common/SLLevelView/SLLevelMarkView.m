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
//等级视图
- (UIButton *)levelView
{
    if (!_levelView) {
        _levelView = [UIButton buttonWithType:UIButtonTypeCustom];
        _levelView.frame = CGRectMake(0, 0, self.width, self.height);
        [_levelView cornerRadiusStyle];

    }
    return _levelView;
}

//设置level的地方
- (void)setLevel:(NSString *)level
{
    _level = level;
    
    [_levelView setTitle:level forState:UIControlStateNormal];
     _levelView.titleLabel.font = Font_Medium(self.height*.55f);
    [_levelView layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:3-level.length];
    switch (_type) {
        case LevelType_Host:
        {
            [_levelView setImage:[UIImage imageNamed:@"masterLevel"] forState:UIControlStateNormal];
            _levelView.backgroundColor = HexRGBAlpha(0xff8b00, 1);
        }
            break;
        case LevelType_ShowCoin:
        {
            [_levelView setImage:[UIImage imageNamed:@"ShowCoinLevel"] forState:UIControlStateNormal];
            _levelView.backgroundColor = kThemeYellowColor;
        }
            break;
        default:
            break;
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
