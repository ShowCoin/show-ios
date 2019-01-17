//
//  SRCoverImageView.m
//  ShowLive
//
//  Created by chenyh on 2019/1/15.
//  Copyright © 2019 vning. All rights reserved.
//

#import "SRCoverImageView.h"

@interface SRCoverImageView ()
// corver add
@property (nonatomic, strong) UIView *corverView;

@end

@implementation SRCoverImageView

/**
 desp add

 @param frame frame set to use
 @return instancetype create

 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.corverView];
    }
    return self;
}

/**
 layoutshubviews
 */
- (void)layoutSubviews {
    self.corverView.frame = self.bounds;
}


/**
 corver alpha

 @param corverAlpha set method
 */
- (void)setCorverAlpha:(CGFloat)corverAlpha {
    self.corverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
}

#pragma mark - lazy

/**
 desp lazy

 @return <#return value description#>
 */
- (UIView *)corverView {
    if (!_corverView) {
        _corverView = [[UIView alloc] init];
        _corverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    }
    return _corverView;
}

@end
