
//
//  SLSmallGiftView.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/17.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLSmallGiftView.h"
#import "SLShakeLabel.h"
#import "SLFontTool.h"
@class SLReceivedGiftModel;

@interface SLSmallGiftView()

@property (nonatomic, strong) UIImageView *bgView;        //礼物背景
@property (nonatomic, strong) SLHeadPortrait *headImageView; // 头像
@property (nonatomic, strong) UIImageView *giftImageView; // 礼物
@property (nonatomic, strong) UILabel *nameLabel; // 送礼物者
@property (nonatomic, strong) UILabel *giftLabel; // 礼物名称

@property (nonatomic, strong) UILabel *largeNumLabel;  //大数据展示

@property (nonatomic, strong) UILabel *doubleClickTag; // 连击标志

@property (nonatomic, weak)   SLShakeLabel *shakeLabel; //跳动数字label

@property (nonatomic, strong) SLReceivedGiftModel *model;

@property (nonatomic, assign) BOOL isShow; // 是否在展示

/**
 本地连击数字
 */
@property (nonatomic, assign) NSInteger doubleClickNum;;

/**
 *  记录本地标记
 */
@property (nonatomic, copy) NSString *mGiftUniTag;


@end

@implementation SLSmallGiftView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // init
        [self initData];
        [self initView];
        
        _mGiftUniTag = @"";
        self.alpha = 0;
        
    }
    
    return self;
}

//static int doubleHitSt;

- (void)showGiftWithModel:(SLReceivedGiftModel *)giftModel
{
    
    _mGiftUniTag = giftModel.giftUniTag;
    self.model = giftModel;
    NSInteger doubleHit = giftModel.double_hit;
    _isShow = YES;
    self.alpha = 1.0;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
         usingSpringWithDamping:0.5
          initialSpringVelocity:2.0
                        options:UIViewAnimationOptionAllowUserInteraction animations:^{
                            
                            self.frame = CGRectMake(10, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
                            
                        } completion:^(BOOL finished) {
                            
                            [self shakeNumberLabelWithCount:doubleHit];
                            
                        }];
}

- (void)shakeNumberLabelWithCount:(NSInteger)count
{
    // 取消延迟执行函数，如果有动画就取消隐藏
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hidePresendView) object:nil];//可以取消成功。
    [self performSelector:@selector(hidePresendView) withObject:nil afterDelay:3.0];
    
    self.shakeLabel.text = [NSString stringWithFormat:@"x %ld",count];
    
    self.shakeLabel.alpha = 1.0; // 设置这个
    [self.shakeLabel startAnimWithDuration:0.3];
}

- (void)hidePresendView
{
    
    self.alpha = 0;
    self.shakeLabel.alpha = 0;
    
    __weak SLSmallGiftView *WeakSelf = self;
    [UIView animateWithDuration:0.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        //        self.alpha = 0;
        //        self.shakeLabel.alpha = 0;
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            //            self.frame = CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            if (WeakSelf.finishCb) {
                WeakSelf.finishCb(finished);
            }
            self->_isShow = NO;
        }
        
    }];
}

#pragma mark -- ifNeed

- (void)dealloc
{
    [self.shakeLabel removeFromSuperview];
    self.shakeLabel = nil;
}

#pragma mark -- 私有

- (void)initData
{
    _isShow = NO;
    
}

/**
 初始化子视图
 */
- (void)initView
{
    [self initBgView];
    [self initHeadView];
    [self initNameLabel];
    [self initGiftDesLabel];
    
    //    [self initLargeNumlabel];
    //    [self initDoubleTag]; 2.3.0
    
    
    [self initGiftImageView];
    [self initShakeLabel];
}

- (void)initBgView
{
    UIImageView *bgView = [[UIImageView alloc]init];
    
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
    bgView.frame           = self.bounds;
    
    bgView.frame = self.bounds;
    bgView.layer.cornerRadius  = self.frame.size.height / 2;
    bgView.layer.masksToBounds = YES;

    // 加渐变渲染
    
//    NSArray *colors = [NSArray arrayWithObjects:(id)[[[UIColor customColorWithString:@"#4500c0"]colorWithAlphaComponent: 0.6] CGColor],
//                       (id)[[[UIColor customColorWithString:@"#850077"]colorWithAlphaComponent: 0.21] CGColor],nil];
//    NSArray *locations = @[@(0.3),@(0.7)];
//    [bgView addGradientStart:CGPointMake(0, 0)
//                         end:CGPointMake(1, 0)
//                      colors:colors
//                   locations:locations];
    
    self.bgView = bgView;
    [self addSubview:self.bgView];
    
}

- (void)initHeadView
{
    SLHeadPortrait *headView = [[SLHeadPortrait alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    
    
    self.headImageView = headView;
    
    [self addSubview:self.headImageView];
}

- (void)initNameLabel
{
    UILabel *label = [[UILabel alloc]init];
    
    CGFloat labelWidth = self.bgView.size.width - self.headImageView.size.width - self.headImageView.origin.x - 43 - 10;
    label.frame    = CGRectMake(_headImageView.frame.size.width + 5, 2, labelWidth, 18);
    
    label.textColor    = [UIColor whiteColor];
    label.shadowColor  = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    label.shadowOffset = CGSizeMake(0, 1.8);
    label.font         = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentLeft;
    NSShadow * shadow        = [[NSShadow alloc]init];
    shadow.shadowColor       = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    shadow.shadowBlurRadius  = 1.5f;
    shadow.shadowOffset      = CGSizeMake(0.0, 1.5);
    [label setValue:shadow forKey:@"shadow"];
    
    label.adjustsFontSizeToFitWidth = YES;
    self.nameLabel = label;
    [self addSubview:self.nameLabel];
    
}

- (void)initGiftDesLabel
{
    UILabel *label = [[UILabel alloc]init];
    
    label.textColor  = [UIColor whiteColor];
    label.font  = [UIFont systemFontOfSize:12];
    label.frame = CGRectMake(_nameLabel.frame.origin.x, 19, _nameLabel.frame.size.width, 17);
    
    NSShadow * shadow        = [[NSShadow alloc]init];
    shadow.shadowColor       = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    shadow.shadowBlurRadius  = 1.5f;
    shadow.shadowOffset      = CGSizeMake(0.0, 1.5);
    [label setValue:shadow forKey:@"shadow"];
    label.textAlignment = NSTextAlignmentLeft;
    self.giftLabel = label;
    [self addSubview:self.giftLabel];
}

- (void)initLargeNumlabel
{
    UILabel *label = [[UILabel alloc]init];
    
    label.font          = [UIFont fontWithName:@"Avenir-HeavyOblique" size:14];
    label.textColor     = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    self.largeNumLabel = label;
    
    [self addSubview:self.largeNumLabel];
}

- (void)initDoubleTag
{
    UILabel *label = [[UILabel alloc]init];
    label.font     = [UIFont systemFontOfSize:14];
    label.textColor= [UIColor redColor];
    label.text     = @"连送";
    
    self.doubleClickTag = label;
    [self addSubview:self.doubleClickTag];
    
}

- (void)initGiftImageView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    self.giftImageView = imageView;
    [self addSubview:self.giftImageView];
    
}

- (void)initShakeLabel
{
    
    __weak SLSmallGiftView *WeakSelf = self;
    
    SLShakeLabel *label = [[SLShakeLabel alloc]init];
    
    label.font          = [UIFont fontWithName:@"Avenir-HeavyOblique" size:20];
    label.borderColor   = randomColor;
    label.textColor     = randomColor;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.finish = [WeakSelf getShakeFinish];
    
    self.shakeLabel = label;
    
    [self addSubview:self.shakeLabel];
}

- (void)setModel:(SLReceivedGiftModel*)model
{
    _model = model;
    
    if (_model) {
        
        [self updateUI:model];
        
        [_headImageView setRoundStyle:YES imageUrl:_model.head_photo imageHeight:45 vip:NO attestation:NO];//yy_setImageWithURL:[NSURL URLWithString:_model.head_photo] placeholder:[UIImage imageNamed:@"placeholder_avatar"]];
        [_giftImageView yy_setImageWithURL:[NSURL URLWithString:_model.goods_pic] placeholder:nil];
        _nameLabel.text = model.nickname;
        _giftLabel.text = [NSString stringWithFormat:@"送出了%@",_model.goods_name];
        
        CGRect rect = [SLFontTool getTextSizeWithSize:20 font:@"Verdana-Italic" string:[NSString stringWithFormat:@"x %ld",(long)_model.double_hit]];
        self.shakeLabel.frame = CGRectMake(CGRectGetMaxX(self.bgView.frame) + 8,0, rect.size.width + 4, 19);
        
        
    }
}

- (void)updateUI:(SLReceivedGiftModel *)model
{
    if (model.num < 1)
    {
        self.width = 213;
        self.bgView.width = 213;
        
        self.largeNumLabel.frame  = CGRectMake(self.width - 42, 0, 40, 23);
        self.doubleClickTag.frame = CGRectMake(self.width - 42, 20, 40, 20);
        self.giftImageView.frame  = CGRectMake(self.width - 40 - 44, self.height - 43, 43, 43);
        
    }else
    {
        self.width = 178;
        self.bgView.width = 178;
        
        self.largeNumLabel.frame  = CGRectZero;
        self.doubleClickTag.frame = CGRectZero;
        self.giftImageView.frame  = CGRectMake(self.width - 44, self.height - 43, 43, 43);
        
    }
    
    self.largeNumLabel.text  = [NSString stringWithFormat:@"x%ld",model.num];
}

- (ShakeFinish)getShakeFinish
{
    __weak SLSmallGiftView *WeakSelf = self;
    
    ShakeFinish finish = ^(BOOL isfinish)
    {
        if(isfinish)
        {
            // NSLog(@"label动画完成");
            WeakSelf.shakeFinishCb(isfinish);
        }
    };
    
    return finish;
}


@end
