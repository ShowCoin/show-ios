//
//  SLHeadPortrait.h
//  ShowLive
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HeadPortraitDelegate <NSObject>

-(void)headPortraitClickAuthor;

@optional

@end
@interface SLHeadPortrait : UIView
{
    CGRect aFrame;
    float vipWidth ;
    float vipHeight ;
    float vipLeft  ;
    float vipTop  ;
}
@property (nonatomic, weak) id<HeadPortraitDelegate> delegate;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIImageView * imageV;
@property (nonatomic,strong)UIImageView *vipIcon;

@property (nonatomic, assign) CGRect selfFrame;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CAShapeLayer *borderLayer;
@property (nonatomic, strong)   UIBezierPath *bezierPath;

- (void)setRoundStyle:(BOOL)roundStyle imageUrl:(NSString *)imageUrl imageHeight:(float)imageheight vip:(BOOL)vip attestation:(BOOL)attestation;
- (void)setRoundStyle:(BOOL)roundStyle image:(UIImage *)image;
- (void)addloadView;

@end
