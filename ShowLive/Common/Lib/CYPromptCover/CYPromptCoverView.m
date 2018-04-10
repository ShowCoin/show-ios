//
//  CYPromptCoverView.m
//  CYPromptCoverTest
//
//  Created by RRTY on 17/2/28.
//  Copyright © 2017年 deepAI. All rights reserved.
//

#import "CYPromptCoverView.h"
#import <Accelerate/Accelerate.h>

@interface CYPromptCoverView ()

@property(nonatomic,strong) UIView *revealView;
@property (nonatomic,strong) UIImage* bgImg;

@property (nonatomic,strong) UIImageView* arrowImgView;

@property (nonatomic,strong) UIButton* dismissBtn;
@property (nonatomic,strong) UIButton* neverBtn;

@end

@implementation CYPromptCoverView

#pragma mark - public
- (void)showInView:(UIView *)view {

    self.alpha = 0.f;
    
    switch (self.coverType) {
            
        case CYPromptCoverViewCoverTypeColored:
            self.bgImg = [self.class imageWithColor:self.coverColor];
            break;
            
        case CYPromptCoverViewCoverTypeBlurred:
            self.bgImg = [self.class blurredImageWithImage:[self.class imageFromView:view andOpaque:NO] radius:self.blurRadius iterations:3 tintColor:[UIColor colorWithWhite:0.0f alpha:0.3f]];
            break;
            
        default:
            break;
    }
    

    
    [view addSubview:self];
    [view setNeedsDisplay];
    
    [UIView animateWithDuration:self.showDuration delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = 1.0f;
                     }
                     completion:nil];
}

- (void)dismiss {
    
    [UIView animateWithDuration:self.dismissDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - init
- (instancetype)
initWithBgColor:(UIColor *)bgColor revealView:(UIView *)revealView revealType:(CYPromptCoverViewRevealType)revealType layoutType:(CYPromptCoverViewLayoutType)layoutType {
    if (self = [super initWithFrame:[[UIScreen mainScreen]bounds]]) {
        
        [self commonSetupWithCoverType:CYPromptCoverViewCoverTypeColored revealType:revealType revealView:revealView layoutType:layoutType];

        self.coverColor = bgColor;
        
        [self setupAttachUI];
    }
    return self;
}

- (instancetype)initWithBlurRadius:(CGFloat)blurRadius revealView:(UIView *)revealView revealType:(CYPromptCoverViewRevealType)revealType layoutType:(CYPromptCoverViewLayoutType)layoutType {
    if (self = [super initWithFrame:[[UIScreen mainScreen]bounds]]) {
        
        [self commonSetupWithCoverType:CYPromptCoverViewCoverTypeBlurred revealType:revealType revealView:revealView layoutType:layoutType];
 
        self.blurRadius = blurRadius;
        
        [self setupAttachUI];
    }
    return self;
}

- (instancetype)initWithRevalView:(UIView *)revalView layoutType:(CYPromptCoverViewLayoutType)layoutType {
    if (self = [super initWithFrame:[[UIScreen mainScreen]bounds]]) {
        
        [self commonSetupWithCoverType:CYPromptCoverViewCoverTypeColored revealType:CYPromptCoverViewRevealTypeRect revealView:revalView layoutType:layoutType];
 
        [self setupAttachUI];
    }
    return self;
}

- (void)commonSetupWithCoverType:(CYPromptCoverViewCoverType)coverType revealType:(CYPromptCoverViewRevealType)revealType revealView:(UIView *)revealView layoutType:(CYPromptCoverViewLayoutType)layoutType {
    //some default configuration
    self.backgroundColor = [UIColor clearColor];
    _tintColor = [UIColor whiteColor];
    self.coverColor = RGBACOLOR(46, 46, 46, .75);
    self.blurRadius = 0.5;
    self.showDuration = 0.2;
    self.dismissDuration = 0.2;
    self.insetX = -5;
    self.insetY = -5;
    
    self.coverType = coverType;
    self.revealType = revealType;
    self.revealView = revealView;
    self.layoutType = layoutType;
    
    self.neverBtnCenter = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height - 30 - 10);
}

- (void)setupAttachUI {

    if (self.isDesHidden) {
        return;
    }
    
    //arrowImageView
    UIImageView *arrowImgView = [[UIImageView alloc] init];
    arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    arrowImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:arrowImgView];
    self.arrowImgView = arrowImgView;
    
    //dismissBtn
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusGesture:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self addGestureRecognizer:tapGesture];

    UISwipeGestureRecognizer * recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self addGestureRecognizer:recognizer];

    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self addGestureRecognizer:recognizer];

    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self addGestureRecognizer:recognizer];

    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    
    [self addGestureRecognizer:recognizer];
    
    //neverBtn
//    UIButton *neverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    neverBtn.titleLabel.font = [UIFont systemFontOfSize:11];
//    [neverBtn setTitle:@"不再提示" forState:UIControlStateNormal];
//    [neverBtn setTitleColor:_tintColor forState:UIControlStateNormal];
//    [neverBtn setBackgroundColor:[UIColor clearColor]];
//    neverBtn.layer.cornerRadius = 10;
//    neverBtn.layer.borderColor = _tintColor.CGColor;
//    neverBtn.layer.borderWidth = 0.5;
//    [neverBtn addTarget:self action:@selector(neverBtnClicked:) forControlEvents:UIControlEventTouchDown];
//    [self addSubview:neverBtn];
//    self.neverBtn = neverBtn;
}
-(void)setShowImage:(UIImage *)showImage
{
    _showImage=showImage;
    [self layoutSubviews];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //neverBtn
    CGFloat neverBtnW = self.showImage.size.width*Proportion375;
    CGFloat neverBtnH = self.showImage.size.height*Proportion375;
 
    //others
    switch (self.layoutType) {
        case CYPromptCoverViewLayoutRecordCenter:
        {
            self.arrowImgView.image = self.showImage;
            NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:24];
            for (NSInteger i = 1; i <= 23; i++) {
                [imageList addObject:[UIImage imageNamed:[NSString stringWithFormat:@"拍摄引导%ld",(long)i]]];
            }
            [self.arrowImgView setAnimationImages:imageList];
            [self.arrowImgView setAnimationDuration:1.5];
            [self.arrowImgView startAnimating];
            self.arrowImgView.frame = CGRectMake((kMainScreenWidth-neverBtnW)/2, (kMainScreenHeight-neverBtnH)/2, neverBtnW, neverBtnH);
            //dismissBtn
            break;
        }
        case CYPromptCoverViewLayoutHomeCenter:
        {
            self.arrowImgView.image = self.showImage;
            NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:24];
            for (NSInteger i = 1; i <= 23; i++) {
                [imageList addObject:[UIImage imageNamed:[NSString stringWithFormat:@"首页引导%ld",(long)i]]];
            }
            [self.arrowImgView setAnimationImages:imageList];
            [self.arrowImgView setAnimationDuration:1.5];
            [self.arrowImgView startAnimating];
            self.arrowImgView.frame = CGRectMake((kMainScreenWidth-neverBtnW)/2, (kMainScreenHeight-neverBtnH)/2, neverBtnW, neverBtnH);
            //dismissBtn
            break;
        }
        case CYPromptCoverViewLayoutWorkCenter:
        {
            self.arrowImgView.image = self.showImage;
            NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:24];
            for (NSInteger i = 1; i <= 23; i++) {
                [imageList addObject:[UIImage imageNamed:[NSString stringWithFormat:@"内容引导%ld",(long)i]]];
            }
            [self.arrowImgView setAnimationImages:imageList];
            [self.arrowImgView setAnimationDuration:1.5];
            self.arrowImgView.animationRepeatCount = 0;// 序列帧动画重复次数
            [self.arrowImgView startAnimating];
            self.arrowImgView.frame = CGRectMake((kMainScreenWidth-neverBtnW)/2, (kMainScreenHeight-neverBtnH)/2, neverBtnW, neverBtnH);
            //dismissBtn
            break;
        }
        case CYPromptCoverViewLayoutTypeCenter:
        {
            self.arrowImgView.image = self.showImage;
            
            self.arrowImgView.frame = CGRectMake((kMainScreenWidth-neverBtnW)/2, (kMainScreenHeight-neverBtnH)/2, neverBtnW, neverBtnH);
            //dismissBtn
            break;
        }
        case CYPromptCoverViewLayoutTypeUP0: {
            
            //arrow
            self.arrowImgView.image = self.showImage;
            self.arrowImgView.frame = CGRectMake((kMainScreenWidth-neverBtnW)/2, kMainScreenHeight-neverBtnH-10, neverBtnW, neverBtnH);
            //dismissBtn
            //subDes
            break;
        }
        case CYPromptCoverViewLayoutTypeUP: {

            //arrow
            self.arrowImgView.image = self.showImage;
            self.arrowImgView.frame = CGRectMake((kMainScreenWidth-neverBtnW)/2, _revealView.top-neverBtnH-10, neverBtnW, neverBtnH);
            //dismissBtn
            //subDes
            break;
        }
        case CYPromptCoverViewLayoutTypeLeftUP: {
            
            //arrow
            self.arrowImgView.image =self.showImage;
            self.arrowImgView.frame = CGRectMake(10, 20, neverBtnW, neverBtnH);
            break;
        }
        case CYPromptCoverViewLayoutTypeLeft: {
            
            //arrow
            self.arrowImgView.image = self.showImage;
            break;
        }
        case CYPromptCoverViewLayoutTypeLeftDown: {
            
            //arrow
            self.arrowImgView.image = self.showImage;
            self.arrowImgView.frame = CGRectMake(_revealView.left-neverBtnW+20, _revealView.bottom+20, neverBtnW, neverBtnH);
            //dismissBtn

            break;
        }
        case CYPromptCoverViewLayoutTypeLeftDown1: {
            
            //arrow
            self.arrowImgView.image = self.showImage;
            self.arrowImgView.frame = CGRectMake(_revealView.left-neverBtnW+40, _revealView.bottom+20, neverBtnW, neverBtnH);
            //dismissBtn
            
            break;
        }

        case CYPromptCoverViewLayoutTypeDown: {
 
            //arrow
            self.arrowImgView.image = self.showImage;
            self.arrowImgView.frame = CGRectMake(_revealView.right-neverBtnW, _revealView.bottom+10, neverBtnW, neverBtnH);
            //dismissBtn
            break;
        }
        case CYPromptCoverViewLayoutTypeRightDown: {
            
            //arrow
            self.arrowImgView.image = self.showImage;
            //            CGRect rect =[self ovalRect];
            self.arrowImgView.frame = CGRectMake(kMainScreenWidth-neverBtnW, kMainScreenHeight-neverBtnH, neverBtnW, neverBtnH);
            //            self.arrowImgView.frame = CGRectMake(_revealView.right+10-_revealView.width/2, rect.origin.y+_revealView.height+10, neverBtnW, neverBtnH);
            
            //dismissBtn
            break;
        }case CYPromptCoverViewLayoutTypeRightDownPay: {
            
            //arrow
            self.arrowImgView.image = self.showImage;
            self.arrowImgView.frame = CGRectMake(kMainScreenWidth-neverBtnW, kMainScreenHeight-neverBtnH-60*Proportion375, neverBtnW, neverBtnH);
            
            //dismissBtn
            break;
        }
        case CYPromptCoverViewLayoutTypeShootUp: {
            
            //arrow
            self.arrowImgView.image = self.showImage;
            NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:24];
            for (NSInteger i = 1; i <= 42; i++) {
                [imageList addObject:[UIImage imageNamed:[NSString stringWithFormat:@"拍摄页引导%ld",(long)i]]];
            }
            [self.arrowImgView setAnimationImages:imageList];
            [self.arrowImgView setAnimationDuration:3];
            [self.arrowImgView startAnimating];
            self.arrowImgView.frame = CGRectMake(0, -38+KTopHeight, kMainScreenWidth, neverBtnH);
//            self.arrowImgView.frame = CGRectMake(arrowX, arrowY, arrowWH, arrowWH);
            
            //dismissBtn
            break;
        }
        case   CYPromptCoverViewLayoutTypeHomeTitle:
        {
            self.arrowImgView =_animationImgView;
            break;
        }
        case CYPromptCoverViewLayoutTypeRightUP: {

            //arrow
//            self.arrowImgView.image = self.showImage;
            self.arrowImgView =_animationImgView;
//            self.arrowImgView.frame = CGRectMake(340*Proportion375-neverBtnW+30*Proportion375, 15, neverBtnW, neverBtnH);

            
            break;
        }
        case CYPromptCoverViewLayoutTypeRightUPWrite: {
            
//            self.arrowImgView.image = self.showImage;
            self.arrowImgView =_animationImgView;
//            self.arrowImgView.frame = CGRectMake(300*Proportion375-neverBtnW, 15, neverBtnW, neverBtnH);
            
            
            break;
        }case CYPromptCoverViewLayoutTypeRightUPEdit: {
            
            //arrow
            self.arrowImgView.image = self.showImage;
            NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:24];
            for (NSInteger i = 1; i <= 51; i++) {
                [imageList addObject:[UIImage imageNamed:[NSString stringWithFormat:@"作品编辑页引导%ld",(long)i]]];
            }
            [self.arrowImgView setAnimationImages:imageList];
            [self.arrowImgView setAnimationDuration:3];
            [self.arrowImgView startAnimating];
            self.arrowImgView.frame = CGRectMake(0, -38+KTopHeight, kMainScreenWidth, neverBtnH);
            break;
        }
        default:
            break;
    }
}

#pragma mark - set
- (void)setRevealView:(UIView *)revealView {
    _revealView = revealView;
    _revealFrame = [self revealRect];
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)setDismissBtnTitle:(NSString *)dismissBtnTitle {
    _dismissBtnTitle = [dismissBtnTitle copy];
    [_dismissBtn setTitle:dismissBtnTitle forState:UIControlStateNormal];
    [self setNeedsDisplay];
}

#pragma mark - drawRect
- (void)drawRect:(CGRect)rect {
    
    if (!self.bgImg) {
        return;
    }
    
//    if (!self.neverBtn) {
//        [self setupAttachUI];
//    }
    
    [self.bgImg drawInRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeClear);
    
//    UIBezierPath* path = nil;
//
//    switch (self.revealType) {
//        case CYPromptCoverViewRevealTypeRect:
//            path = [UIBezierPath bezierPathWithRoundedRect:[self revealRect] cornerRadius:4];
//            break;
//        case CYPromptCoverViewRevealTypeOval:{
//            CGRect rect = [self ovalRect];
//            path = [UIBezierPath bezierPathWithOvalInRect:rect];
//        }
//            break;
//        default:
//            break;
//    }
    [[UIColor clearColor] set];
//    [path fill];
    [self layoutSubviews];
}

#pragma mark - drawRect pravite
- (CGRect)revealRect {
    
    CGRect realRect = [_revealView.superview convertRect:_revealView.frame toView:self];
    return CGRectInset(realRect, _insetX, _insetY);
}

- (CGRect)ovalRect {
    
    CGRect rect = [self revealRect];
    //圆的直径
    CGFloat diameter = floorf(sqrtf(rect.size.width*rect.size.width + rect.size.height*rect.size.height));
    CGFloat rate = rect.size.width/rect.size.height;
    CGSize newSize;
    if (rate >= 1) {//宽大于长
        newSize = CGSizeMake(diameter, diameter/rate);
    } else {
        newSize = CGSizeMake(diameter/rate,diameter);
    }
    
    return CGRectMake(rect.origin.x - (newSize.width - rect.size.width)/2.0f, rect.origin.y - (newSize.height - rect.size.height)/2.0f, newSize.width, newSize.height);
}

#pragma mark - btnClicked
- (void)neverBtnClicked:(UIButton *)btn {

    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(CYPromptCoverViewDidClickedNeverBtn:)]) {
        [self.delegate CYPromptCoverViewDidClickedNeverBtn:self];
    }
}
- (void)focusGesture:(UITapGestureRecognizer*)gesture {
    
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(CYPromptCoverViewDidClickedDismissBtn:)]) {
        [self.delegate CYPromptCoverViewDidClickedDismissBtn:self];
    }
}
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(CYPromptCoverViewDidClickedDismissBtn:)]) {
        [self.delegate CYPromptCoverViewDidClickedDismissBtn:self];
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"swipe down");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"swipe up");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"swipe right");
    }
}


#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //过滤掉触摸事件
    if (self.desHidden) {
        [self dismiss];
        if (self.delegate && [self.delegate respondsToSelector:@selector(CYPromptCoverViewDidClickedDismissBtn:)]) {
            [self.delegate CYPromptCoverViewDidClickedDismissBtn:self];
        }
    }
}

#pragma mark - Image Tool

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)imageFromView:(UIView *)view andOpaque:(BOOL) opaque
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, opaque, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)blurredImageWithImage:(UIImage *)image radius:(CGFloat)radius iterations:(NSUInteger)iterations  tintColor:(UIColor *)tintColor
{
    //为radius参数设定对外取值范围
    if (radius < 0 || radius > 1) {
        radius = 0.5;
    }
    radius = radius * 20;
    
    
    //image must be nonzero size
    NSAssert(image.size.width > 0 && image.size.height > 0, @"size error");
    
    //boxsize must be an odd integer
    uint32_t boxSize = radius * image.scale;
    if (boxSize % 2 == 0) boxSize ++;
    
    //create image buffers
    CGImageRef imageRef = image.CGImage;
    vImage_Buffer buffer1, buffer2;
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    CFIndex bytes = buffer1.rowBytes * buffer1.height;
    buffer1.data = malloc(bytes);
    buffer2.data = malloc(bytes);
    
    //create temp buffer
    void *tempBuffer = malloc(vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize,
                                                         NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));
    
    //copy image data
    CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
    CFRelease(dataSource);
    
    for (NSUInteger i = 0; i < iterations; i++)
    {
        //perform blur
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        //swap buffers
        void *temp = buffer1.data;
        buffer1.data = buffer2.data;
        buffer2.data = temp;
    }
    
    free(buffer2.data);
    free(tempBuffer);
    
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
                                             8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
                                             CGImageGetBitmapInfo(imageRef));
    
    //apply tint
    if (tintColor && CGColorGetAlpha(tintColor.CGColor) > 0.0f)
    {
        CGContextSetFillColorWithColor(ctx, tintColor.CGColor);
        CGContextSetBlendMode(ctx, kCGBlendModeNormal);
        CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
    }
    
    
    imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    free(buffer1.data);
    return newImage;
}

@end
