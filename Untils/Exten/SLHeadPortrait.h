//
//  SLHeadPortrait.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadPortraitDelegate <NSObject>

@optional

- (void)headPortraitClickAuthor;
- (void)headPortraitClickAuthor:(id)head;

@end

@interface SLHeadPortrait : UIView
{
    CGRect aFrame;
    float vipWidth;
    float vipHeight;
    float vipLeft;
    float vipTop;
}
@property (nonatomic, weak) id <HeadPortraitDelegate> delegate;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *vipIcon;

@property (nonatomic, assign) CGRect selfFrame;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CAShapeLayer *borderLayer;
@property (nonatomic, strong) UIBezierPath *bezierPath;

- (void)setRoundStyle:(BOOL)roundStyle imageUrl:(NSString *)imageUrl imageHeight:(float)imageheight vip:(BOOL)vip attestation:(BOOL)attestation;
- (void)setRoundStyle:(BOOL)roundStyle imageUrl:(NSString *)imageUrl holdImg:(UIImage *)holdImg imageHeight:(float)imageheight vip:(BOOL)vip attestation:(BOOL)attestation;
- (void)setRoundStyle:(BOOL)roundStyle image:(UIImage *)image;
- (void)addloadView;

- (void)removeTap;

@end
