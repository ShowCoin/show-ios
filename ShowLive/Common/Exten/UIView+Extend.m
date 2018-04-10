//
//  UIView+Extend.m
//  library
//
//  Created by Shingo on 13-8-2.
//  Copyright (c) 2013年 Shingo. All rights reserved.
//

#import "UIView+Extend.h"

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView(Extend)

/*- (UIViewController *)viewController {
    
    //for (UIView* next = [self superview]; next; next = next.superview) {
        
        UIResponder* nextResponder = [self nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController*)nextResponder;
        }
    //}
    return nil;
}*/

+ (UIView *)viewWithName:(NSString *)name {
    
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] objectAtIndex:0];
}

- (BOOL)isBelongToSuperViewOfClass:(Class)Class {
 
    if (!self.superview)
        return NO;
    else if ([self isKindOfClass:Class] || [self.superview isKindOfClass:Class])
        return YES;
    else
        return [self.superview isBelongToSuperViewOfClass:Class];
}

- (UIViewController *) viewController {
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

- (void)clearBorderStyle {
    
    self.layer.borderWidth = 0;
    self.layer.masksToBounds = YES;
}

- (void)searchContainerStyle {
    
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)lightBorderStyle {
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = RGBACOLOR(240, 240, 240, 1).CGColor;
    self.layer.masksToBounds = YES;
}

- (void)borderStyle {
    
    [self borderStyleWithColor:RGBACOLOR(225,225,225,1)];
}
- (void)borderStyleWithColor:(UIColor *)color width:(CGFloat)width
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.masksToBounds = YES;
    
}
- (void)borderStyleWithColor:(UIColor *)color{
    
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = color.CGColor;
    self.layer.masksToBounds = YES;
}

- (void)heavyborderStyle {
    
    self.layer.borderWidth = 2;
    self.layer.borderColor = RGBACOLOR(200, 200, 200, 1).CGColor;
    self.layer.masksToBounds = YES;
}

- (void)cornerRadiusStyle {
    
    self.layer.cornerRadius = 3.0f;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)cornerRadiusStyleWithValue:(CGFloat)value {
    
    self.layer.cornerRadius = value;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)roundStyle {
    
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
//    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)roundHeightStyle {
    
    self.layer.cornerRadius =self.frame.size.height / 2;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (UIColor *)colorAtPosition:(CGPoint)position {
    
    CGPoint p = CGPointMake(position.x / self.frame.size.width, position.y / self.frame.size.height);
    
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef cgImage = [image CGImage];
    CGDataProviderRef provider = CGImageGetDataProvider(cgImage);
    CFDataRef bitmapData = CGDataProviderCopyData(provider);
    const UInt8* data = CFDataGetBytePtr(bitmapData);
    size_t bytesPerRow = CGImageGetBytesPerRow(cgImage);
    size_t width = CGImageGetWidth(cgImage);
    size_t height = CGImageGetHeight(cgImage);
    int col = p.x*(width-1);
    int row = p.y*(height-1);
    const UInt8* pixel = data + row*bytesPerRow+col*4;
    UIColor* returnColor = [UIColor colorWithRed:pixel[2]/255. green:pixel[1]/255. blue:pixel[0]/255. alpha:1.0];
    CFRelease(bitmapData);
    return returnColor;
}

- (CGSize)fitSize {
    
    CGRect rect = self.frame;
    [self sizeToFit];
    CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    return size;
}

- (void)setFrameWithType:(FrameType)type value:(CGFloat)value {
    
    [self setFrameWithType:type value:value maxValue:0];
}

- (void)setFrameWithType:(FrameType)type value:(CGFloat)value maxValue:(CGFloat)maxValue {
    
    CGRect rect = self.frame;
    if (type == FrameTypeX)
        rect.origin.x = maxValue == 0 ? value : (value > maxValue ? maxValue : value);
    else if (type == FrameTypeY)
        rect.origin.y = maxValue == 0 ? value : (value > maxValue ? maxValue : value);
    else if (type == FrameTypeWidth)
        rect.size.width = maxValue == 0 ? value : (value > maxValue ? maxValue : value);
    else if (type == FrameTypeHeight)
        rect.size.height = maxValue == 0 ? value : (value > maxValue ? maxValue : value);
    self.frame = rect;
}

- (UIImage *)screenshot {
    
    CGSize s = self.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (id)initWithScaledFrame:(CGRect)frame {
    
    return [[super init] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width*Proportion375, frame.size.height*Proportion375)];
}

// Retrieve and set the origin
- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width =newwidth;
    self.frame = newframe;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x =newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;	
}

- (void)lineDockTopWithColor:(UIColor *)color {
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5f)];
    lineView.backgroundColor = color;
    lineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self insertSubview:lineView atIndex:0];
}

- (void)lineDockBottomWithColor:(UIColor *)color {
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5f, self.width, 0.5f)];
    lineView.backgroundColor = color;
    lineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self insertSubview:lineView atIndex:0];
}
- (void)lineDockBottomWithColor:(UIColor *)color withLeft:(CGFloat)left{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(left, self.height - 0.5f, self.width-left*2, 0.5f)];
    lineView.backgroundColor = color;
    lineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self insertSubview:lineView atIndex:0];
}
- (void)lineDockLeftWithColor:(UIColor *)color {
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5f, self.height)];
    lineView.backgroundColor = color;
    lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    [self insertSubview:lineView atIndex:0];
}

- (void)lineDockRightWithColor:(UIColor *)color {
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.width - 0.5f, 0, 0.5f, self.height)];
    lineView.backgroundColor = color;
    lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    [self insertSubview:lineView atIndex:0];
}
-(void)playAnimation
{
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pulse.duration = 0.15;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:1];
    pulse.toValue= [NSNumber numberWithFloat:0.8];
    pulse.removedOnCompletion = NO;
    pulse.fillMode = kCAFillModeForwards;
    [[self layer] addAnimation:pulse forKey:nil];

}
@end
