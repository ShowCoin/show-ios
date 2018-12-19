//
//  SLControlView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLControlView.h"
#import "HomeHeader.h"


/**
 SLControlView
 */
@implementation SLControlView {
    BOOL _isFirst;
}


/**
 initWithFrame

 @param frame <#frame description#>
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
   

        _isFirst = YES;
        
        [self addMask];
        
        if ([HomeHeader isHot]) {
            [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(sl_tabbarHidden:) name:SLLiveHideTabbarNotification object:nil];
        }
        
    }
    return self;
    
}

-(void)removeMask
{
    [_gradiedtLayer removeFromSuperlayer];
}

-(void)addMask
{
    //底部遮罩
    _gradiedtLayer = [[CAGradientLayer alloc] init];
    _gradiedtLayer.frame = CGRectMake(0, kScreenHeight-25.5*5-100-KTabbarSafeBottomMargin,kScreenWidth,25.5*5+100+KTabbarSafeBottomMargin);
    _gradiedtLayer.colors = [NSArray arrayWithObjects:(id)[[[UIColor blackColor] colorWithAlphaComponent:0] CGColor],
                             (id)[[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor],
                             nil];
    _gradiedtLayer.locations =
    [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
     [NSNumber numberWithFloat:1.0],
     nil];
    _gradiedtLayer.startPoint = CGPointMake(0,0);
    _gradiedtLayer.endPoint = CGPointMake(0,1);
    [self.layer addSublayer:_gradiedtLayer];
}



- (void)dealloc{
    NSLog(@"[gx] controlview dealloc");
}

- (void)removeFromSuperview {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)sl_tabbarHidden:(NSNotification *)noti {
    NSLog(@"[187] -- sl_tabbarHidden %@", [noti.object boolValue] ? @"YES" : @"NO");
    [self showAnimate:[noti.object boolValue]];
}

- (void)showAnimate:(BOOL)show {
    self.hidden = NO;
    for (UIView *v in self.subviews) {
        if ([v respondsToSelector:@selector(sl_viewAnimationShow:)]) {
            [v performSelector:@selector(sl_viewAnimationShow:) withObject:[NSNumber numberWithBool:show]];
        }
    }
}

//- (void)setHidden:(BOOL)hidden {
//    if (_isFirst) {
//        [super setHidden:hidden];
//        _isFirst = NO;
//        return;
//    }
//    [super setHidden:NO];
//    for (UIView *v in self.subviews) {
//        if ([v respondsToSelector:@selector(sl_viewAnimationShow:)]) {
//            [v performSelector:@selector(sl_viewAnimationShow:) withObject:[NSNumber numberWithBool:hidden]];
//        }
//    }
//}

@end
