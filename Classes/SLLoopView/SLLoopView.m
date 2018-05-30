//
//  AnimateVIew.m
//  test
//
//  Created by 陈英豪 on 2018/5/23.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLLoopView.h"
#import "HomeHeader.h"

static NSString * const kAnimationKey    = @"AnimationKey";
static NSString * const kAnimationFirst  = @"kAnimationFirst";
static NSString * const kAnimationSecond = @"kAnimationSecond";

CGFloat const kLoopTopMargin = 6;
CGFloat const kSLLoopViewHeight = 44 + 6 + 6;

typedef void(^LoopBlock)(CAAnimation *anim, BOOL flag);

@interface LoopAnimationDelegate : NSObject <CAAnimationDelegate>

@property (nonatomic, copy) LoopBlock loopBlock;

@end

@implementation LoopAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.loopBlock) {
        self.loopBlock(anim, flag);
    }
}

@end

@interface SLLoopView () <CAAnimationDelegate>

@property (nonatomic, weak) CAReplicatorLayer *reLayer;
@property (nonatomic, strong) SLLoopContentView *titleView;
@property (nonatomic, strong) SLLoopContentView *imageView;

@end

@implementation SLLoopView{
    BOOL isEndAni;
}

+ (instancetype)shared {
    static SLLoopView *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SLLoopView alloc] init];
        instance.frame = CGRectMake(0, 0, KScreenWidth * 2, kSLLoopViewHeight);
        //[instance addTimer];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (SLLoopContentView *)titleView {
    if (!_titleView) {
        _titleView = [[SLLoopContentView alloc] init];
        _titleView.imageView.hidden = YES;
    }
    return _titleView;
}

- (SLLoopContentView *)imageView {
    if (!_imageView) {
        _imageView = [[SLLoopContentView alloc] init];
        _imageView.textLabel.text = @"我是音乐: 一条鱼~~";
    }
    return _imageView;
}

- (void)setup {
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    [layer addSublayer:self.titleView.layer];
    [layer addSublayer:self.imageView.layer];
    layer.instanceCount = 2;
    [self.layer addSublayer:layer];
    self.reLayer = layer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    self.titleView.frame = CGRectMake(0, 0, w / 2, h);
    self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleView.frame), 0, CGRectGetWidth(self.titleView.frame), h);
}


#pragma mark - Public

- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle {
    self.titleView.textLabel.text = title;
}

static BOOL isFirst = YES;

- (void)beginAnimation {
    isEndAni = NO;
    NSTimeInterval t = isFirst ? 7 : 3;
    isFirst = NO;
    [self performSelector:@selector(startAnimation:) withObject:nil afterDelay:t];
}

- (void)endAnimation {
    isEndAni = YES;
    [self.layer removeAllAnimations];
}


@end

@interface SLLoopContentView ()

@property (nonatomic, weak) SLRotationImageView *imageView;
@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation SLLoopContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *textLabel = [SLShadowLabel new];
    textLabel.text = @"textLabel textLabel";
    textLabel.textColor = kThemeWhiteColor;
    textLabel.font = Font_Medium(14);
    textLabel.layer.shadowRadius = 0.0f;
    textLabel.layer.shadowOpacity = 0.3;
    textLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    textLabel.layer.shadowOffset = CGSizeMake(1,1);
    textLabel.layer.masksToBounds = NO;
    [self addSubview:textLabel];
    self.textLabel = textLabel;
    
    SLRotationImageView *imageView = [[SLRotationImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"live_bottom_music"];
    [self addSubview:imageView];
    self.imageView = imageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.textLabel.frame = CGRectMake(15, 0, w * 0.7, h);
    CGFloat margin = 5;
    CGFloat imageWH = h - margin * 2;
    self.imageView.frame = CGRectMake(w - 10 - imageWH, margin, imageWH, imageWH);
}

- (void)didMoveToSuperview {
    [self.imageView addRotationAnimated];
}

@end

@implementation SLRotationImageView

- (void)addRotationAnimated {
    [self.layer removeAllAnimations];
    CABasicAnimation *ani = [CABasicAnimation animation];
    ani.keyPath = @"transform.rotation.z";
    ani.fromValue = @0;
    ani.toValue = @(M_PI *2);
    ani.duration = 10;
    ani.repeatCount = HUGE_VALF;
    ani.fillMode = kCAFillModeForwards;
    ani.removedOnCompletion = NO;
    [self.layer addAnimation:ani forKey:@"imageViewAni"];
}

@end
