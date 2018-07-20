//
//  SLRightTextField.h
//  test
//
//  Created by chenyh on 2018/7/10.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kSLRightTextFieldH;

typedef NS_ENUM(NSUInteger, SLFieldRightType) {
    SLFieldRightTypeNormal,
    SLFieldRightTypePwd,
    SLFieldRightTypeQR,
    SLFieldRightTypeVCode,// phone register
    SLFieldRightTypeEmailVCode,
};

typedef NS_ENUM(NSUInteger, SLVerifyCodeType) {
    SLVerifyCodeTypeNormal,
    SLVerifyCodeTypePhone,
    SLVerifyCodeTypeEmail,
};

@interface SLRightTextField : UITextField

@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, assign) SLFieldRightType rightType;
@property (nonatomic, assign) BOOL showBottomLine; // default YES
@property (nonatomic, assign) BOOL showTopLine; // default NO
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) NSString *leftTitle;

@property (nonatomic, copy) SLSimpleBlock rightBlock;

- (void)sl_getVerifyCodeWithPhone:(NSString *)phone;

@end


@interface SLVerificationButton : UIButton

@property (nonatomic, assign) SLVerifyCodeType type;

- (void)sl_getVerifyCodeWithPhone:(NSString *)phone;

@end
