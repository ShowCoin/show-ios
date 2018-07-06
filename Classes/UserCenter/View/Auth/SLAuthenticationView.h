//
//  SLIdCardVIew.h
//  test
//
//  Created by chenyh on 2018/7/2.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLBaseModalView.h"
typedef void(^SLSimpleBlock)(void);

typedef NS_ENUM(NSUInteger, SLIdCardType) {
    SLIdCardTypePros,
    SLIdCardTypeCons,
    SLIdCardTypeHand,
};

typedef NS_ENUM(NSUInteger, SLAuthImageType) {
    SLAuthImageTypeNormal,
    SLAuthImageTypeAuthing,
    SLAuthImageTypeSuccess,
    SLAuthImageTypeFailed,
};

#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define SLNormalColor HexRGBAlpha(141414, 1);

@interface SLAuthImageView : UIImageView

@property (nonatomic, assign) SLAuthImageType type;

@end

@interface SLAuthenticationView : UIView

@property (nonatomic, copy) SLSimpleBlock clickBlock;
@property (nonatomic, weak, readonly) UIImageView *imageView;
@property (nonatomic, assign) SLIdCardType type;
@property (nonatomic, assign, readonly) CGFloat viewH;

@property (nonatomic, copy) NSString *errorMsg;

- (void)showAuthImageType:(SLAuthImageType)type;

@end


@interface SLAICountryView : UITableViewCell

@property (nonatomic, weak, readonly) UILabel *detialLabel;
+ (instancetype)countryView;

@end


@interface SLCountryModalView : SLBaseModalView;

@end
