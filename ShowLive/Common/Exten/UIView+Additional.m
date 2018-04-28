//
//  UIView+UIView_Additional.m
//  I500user
//
//  Created by ShanWu on 15/4/9.
//  Copyright (c) 2015年 WorkNew. All rights reserved.
//

#import "UIView+Additional.h"
#import <objc/runtime.h>

@implementation UIView (Additional)
- (void)addShadowWithColor:(UIColor *)color radius:(float)radius{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = radius;
    self.layer.shouldRasterize = YES;
    self.layer.shadowOpacity = 1;
    self.layer.rasterizationScale = kScreenScale;
}
-(void)addDefaultShadow1
{
    self.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 1;//阴影透明度，默认0
    self.layer.shadowRadius = 3;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float addWH = 10;
    
    CGPoint topLeft      = self.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);
    
    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);
    
    
    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
    
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    //设置阴影路径
    self.layer.shadowPath = path.CGPath;
}
- (void)addDefaultShadow{
    [self addShadowWithColor:[[UIColor blackColor] colorWithAlphaComponent:.2] radius:5];
}
- (void)setBackupAlpha:(CGFloat)backupAlpha
{
    objc_setAssociatedObject(self, @"backupAlpha", @(backupAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)backupAlpha{
    NSNumber *temp = objc_getAssociatedObject(self, @"backupAlpha");
    if (!temp) {
        return -1;
    }
    return [temp floatValue];
}
- (void)setBackupCenter:(CGPoint)backupCenter{
    objc_setAssociatedObject(self, @"backupCenter", [NSValue valueWithCGPoint:backupCenter], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)backupCenter{
    NSValue *temp = objc_getAssociatedObject(self, @"backupCenter");
    if (!temp) {
        return CGPointMake(-1, -1);
    }
    return [temp CGPointValue];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x = scrollView.contentOffset.x;
        }
    }
    
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}

#pragma mark -
#pragma mark custom add method
- (UITableViewCell *)tableViewCell{
    UIView *superView = self.superview;
    while (superView != nil && ![superView isKindOfClass:[UITableViewCell class]]) {
        superView = superView.superview;
    }
    return (UITableViewCell *)superView;
}

- (UITableView *)tableView{
    UIView *superView = self.superview;
    while (superView != nil && ![superView isKindOfClass:[UITableView class]]) {
        superView = superView.superview;
    }
    return (UITableView *)superView;
}

- (void)animatedShowShadow{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.fromValue = (id)[[UIColor clearColor] CGColor];
    animation.toValue = (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] CGColor];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.5;
    [self.layer addAnimation:animation forKey:@"FadeAnimation"];
}

- (void)backgroundColorAnimationOnlayerColor:(UIColor *)color toColor:(UIColor *)toColor{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.fromValue = (id)color.CGColor;
    animation.toValue = (id)toColor.CGColor;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.5;
    [self.layer addAnimation:animation forKey:@"FadeAnimation"];
}

- (NSObject *)attachment {
    return objc_getAssociatedObject(self, @"kViewAttachment");
}

- (void)setAttachment:(NSObject *)attachment {
    objc_setAssociatedObject(self, @"kViewAttachment",nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @"kViewAttachment",attachment, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)createMaskWithDuration:(NSTimeInterval)duration{
    UIView * mask=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    mask.backgroundColor=kthemeBlackColor;
    [mask cornerRadiusStyle];
    [self addSubview:mask];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor  whiteColor].CGColor,(id)[UIColor clearColor].CGColor];
    layer.locations = @[@(0.25),@(0.5),@(0.75)];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    mask.layer.mask = layer;
    layer.position = CGPointMake(-self.bounds.size.width/4.0, self.bounds.size.height/2.0);
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform.translation.x";
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(self.bounds.size.width+self.bounds.size.width/2.0);
    basicAnimation.duration = duration;
    basicAnimation.repeatCount = LONG_MAX;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    [mask.layer.mask addAnimation:basicAnimation forKey:nil];
}
- (void)addShadow
{
    self.layer.shadowRadius = .5f;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = RGBACOLOR(46, 46, 46, .4).CGColor;
    self.layer.shadowOffset = CGSizeMake(.5, .5);
    self.layer.masksToBounds = NO;
}
-(void)addEffect:(UIBlurEffectStyle)type
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:type];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.tag=5120;
    effectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    effectView.userInteractionEnabled= NO;
    [self insertSubview:effectView atIndex:0];
}
-(void)addFullEffect:(UIBlurEffectStyle)type
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:type];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.tag=5121;
    effectView.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
    effectView.userInteractionEnabled= NO;
    [self insertSubview:effectView atIndex:0];
}
-(void)layerWithColor:(UIColor *)color width:(CGFloat)width
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, self.width, self.height);
    borderLayer.frame = CGRectMake(0, 0, self.width, self.height);
    borderLayer.lineWidth = width;
    borderLayer.strokeColor = color.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.width, self.height) cornerRadius:self.height];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    [self.layer insertSublayer:borderLayer atIndex:0];
    [self.layer setMask: maskLayer];
    
}
@end
