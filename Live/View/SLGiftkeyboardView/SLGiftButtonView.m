//
//  SLGiftButtonView.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLGiftButtonView.h"
#import "SLFontTool.h"

@interface SLGiftButtonView ()<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView  *giftImageView;   // 礼物图片

@property (nonatomic, strong) CATextLayer  *presentNameLayer; // 礼物名字

@property (nonatomic, strong) CATextLayer  *presentCurrentPrice; // 礼物价格

@property (nonatomic, strong) CAShapeLayer *selectedFrame; // 选中的矩形框

@property (nonatomic, strong) UIColor      *cornerSignColor; // 选中框的颜色

@property (nonatomic, assign) SLGiftKindType giftKindType;  // 礼物类型

@property (nonatomic, strong) UIImageView  *taglabel;    // 礼物标签

@property (nonatomic, strong) UIImageView  *selectTag;   // 选中标签

@property (nonatomic, strong) NSMutableArray *imageArr;

@property (nonatomic, strong) UILabel *packGiftNumLabel;


/**
 初始化数据
 */
- (void)initData;

/**
 初始化子视图
 */
- (void)initView;

@end
@implementation SLGiftButtonView

- (instancetype)initWithFrame:(CGRect)frame infoModel:(SLGiftListModel *)model
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.giftModel    = model;
        [self initView]; // 初始化标签
        [self addTouch];

    }
    return self;
}

- (void)initData
{
    self.imageArr = [NSMutableArray new];
}

- (void)initView
{
    if(_giftModel.image != NULL)
    {
        [self configCornerSignParameter];
        [self setupUI];
        [self selectedState];
    }
    else
    {
        [self setupDefaultUI];
    }
    
}

- (void)addTouch
{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
    
    [self addGestureRecognizer:tapGesture];
}

- (void)configCornerSignParameter
{
    _cornerSignColor = [UIColor redColor];
    
}


- (void)initTag
{
    UIImageView *imageVeiw = [[UIImageView alloc]init];
    
    imageVeiw.width  = 74/3.0;
    imageVeiw.height = 29/3.0;
    imageVeiw.mj_x      = 2;
    imageVeiw.mj_y      = 0;
    self.taglabel = imageVeiw;
    [self addSubview:self.taglabel];
    
}

- (void)setupDefaultUI
{
    self.backgroundColor = [UIColor clearColor];
    CGFloat imageWidth = self.bounds.size.height * 0.6;
    _giftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
    
    _giftImageView.backgroundColor = [UIColor clearColor];
    
    _giftImageView.center = CGPointMake(self.bounds.size.width / 2.0, _giftImageView.frame.size.height / 2.0 + 7);
    [self addSubview:_giftImageView];
    _giftImageView.image = [UIImage imageNamed:@"gift_lock"];

    
    _presentNameLayer = [CATextLayer layer];
    
    CGRect presentNameRect = [SLFontTool getTextSizeWithSize:10 font:@"PingFangSC-Regular" string:@"敬请期待"];
    presentNameRect.size.width = self.size.width;
    _presentNameLayer.frame = presentNameRect;
    
    //设置字体属性
    _presentNameLayer.foregroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7].CGColor;
    _presentNameLayer.alignmentMode = kCAAlignmentCenter;
    _presentNameLayer.wrapped = YES;
    UIFont *presentNameFont = [UIFont systemFontOfSize:10];
    
    //set layer font
    CFStringRef presentNameFontName = (__bridge CFStringRef)presentNameFont.fontName;
    
    CGFontRef presentNameFontRef = CGFontCreateWithFontName(presentNameFontName);
    _presentNameLayer.font = presentNameFontRef;
    _presentNameLayer.fontSize = presentNameFont.pointSize;
    CGFontRelease(presentNameFontRef);
    
    _presentNameLayer.contentsScale = [UIScreen mainScreen].scale;
    
    
    _presentNameLayer.string = @"敬请期待";
    [self.layer addSublayer:_presentNameLayer];
    
    _presentNameLayer.position = CGPointMake(_presentNameLayer.position.x,
                                             self.bounds.size.height - 20);
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor clearColor];
    //设置礼物图片Icon
    CGFloat imageWidth = self.bounds.size.height * 0.68;
    _giftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
    _giftImageView.center = CGPointMake(self.bounds.size.width / 2.0, _giftImageView.frame.size.height / 2.0 + 3);
    [self addSubview:_giftImageView];
    if(_giftModel.image == NULL)
    {
        _giftImageView.image = [UIImage imageNamed:@"gift_lock"];
    }
    else{
        
        if (IsStrEmpty(_giftModel.image)) {
            [_giftImageView setImage:[UIImage imageNamed:@"placeholder_avatar"]];
        }else
            
        {
            [_giftImageView yy_setImageWithURL:[NSURL URLWithString:_giftModel.image] placeholder:[UIImage imageNamed:@"placeholder_avatar"]];
        }
        
    }
    
    
    NSString *priceStr = [NSString stringWithFormat:@"%ld", self.giftModel.price];

    UILabel *nameLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_giftImageView.frame), self.width, 9)];
    
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font      = [UIFont systemFontOfSize:9];
    nameLabel.text      = self.giftModel.name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    

    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                   CGRectGetMaxY(nameLabel.frame) + 1,
                                                                   self.width,9)];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.font      = [UIFont systemFontOfSize:7];
    priceLabel.text      = priceStr;
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:priceLabel];

    [self initTag];

}

- (void)setNum:(NSInteger)num {
    
    self.packGiftNumLabel.text = [NSString stringWithFormat:@"数量: %ld",num];
}

- (void)selectedState
{

    _selectedFrame = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    _selectedFrame.path = path.CGPath;
    _selectedFrame.fillColor = [UIColor clearColor].CGColor;
    _selectedFrame.strokeColor = _cornerSignColor.CGColor;
    _selectedFrame.lineWidth = 1.0f;
    [self.layer addSublayer:_selectedFrame];
    _selectedFrame.hidden = YES;
    
    
}


- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    _selectedFrame.hidden = !_isSelected;
    
    if (_isSelected) {
        
        self.selectTag.hidden = NO;
        
        [self starAnimation];
        [self giftBoxAnimation];
    }
    else{
        
        self.selectTag.hidden = YES;
        
        [self stopAnimation];
        [self removeAnimation];
        
        
    }
}

- (void)event:(UITapGestureRecognizer *)gesture
{
    if(_giftModel.image != NULL)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedGift:)]) {
            [self.delegate selectedGift:self];
        }
    }
}

// 帧动画的创建

- (void)creatAnimation
{
    

    if (!self.imageArr.count) return;
    // 设置图片的序列帧 图片数组
    _giftImageView.animationImages = self.imageArr;
    //动画重复次数
    _giftImageView.animationRepeatCount = 0;
    //动画执行时间,多长时间执行完动画
    _giftImageView.animationDuration = 1.0;
}

- (void)starAnimation
{
    if (!self.imageArr.count) return;
    if (_giftImageView.animating) return;
    
    [_giftImageView startAnimating];
}

- (void)stopAnimation
{
    if (!self.imageArr.count) return;
    if (_giftImageView.animating) {
        
        [_giftImageView stopAnimating];
    }
}

// 抖动动画
- (void)giftBoxAnimation
{
    [_giftImageView.layer removeAllAnimations];
    CAKeyframeAnimation *giftBoxRotAnimation = [CAKeyframeAnimation animation];
    giftBoxRotAnimation.keyPath = @"transform.rotation";
    giftBoxRotAnimation.values   = @[@0   , @-0.2f, @0.2f , @-0.2f, @0.2f , @0.0f , @0.0f];//弧度
    giftBoxRotAnimation.keyTimes = @[@0.0f, @0.01 , @0.025, @0.04 , @0.055, @0.065, @1];
    giftBoxRotAnimation.duration = 3.5;
    giftBoxRotAnimation.additive = YES;
    giftBoxRotAnimation.repeatCount = INFINITY;
    giftBoxRotAnimation.delegate = self;
    //    [giftBoxLayer addAnimation:giftBoxRotAnimation forKey:giftBoxRotAnimation.keyPath];
    
    CAKeyframeAnimation *giftBoxPosAnimation = [CAKeyframeAnimation animation];
    giftBoxPosAnimation.keyPath = @"position";
    giftBoxPosAnimation.values = @[[NSValue valueWithCGPoint:CGPointZero],
                                   [NSValue valueWithCGPoint:CGPointMake(-1, -2)],
                                   [NSValue valueWithCGPoint:CGPointMake(1, -2)],
                                   [NSValue valueWithCGPoint:CGPointMake(-1, -2)],
                                   [NSValue valueWithCGPoint:CGPointMake(1, -2)],
                                   [NSValue valueWithCGPoint:CGPointZero],
                                   [NSValue valueWithCGPoint:CGPointZero]];
    giftBoxPosAnimation.keyTimes = @[@0.0f, @0.01 , @0.025, @0.04 , @0.055, @0.065, @1];
    giftBoxPosAnimation.duration = 3.5;
    giftBoxPosAnimation.additive = YES;
    giftBoxPosAnimation.repeatCount = INFINITY;
    giftBoxPosAnimation.delegate = self;
    
    CAAnimationGroup *giftAnimationGroup = [[CAAnimationGroup alloc] init];
    giftAnimationGroup.animations = @[giftBoxRotAnimation, giftBoxPosAnimation];
    giftAnimationGroup.duration = 3.5;
    giftAnimationGroup.repeatCount = INFINITY;
    
    [_giftImageView.layer addAnimation:giftAnimationGroup forKey:@"shake"];
    
}

- (void)removeAnimation
{
    [_giftImageView.layer removeAllAnimations];
}



@end
