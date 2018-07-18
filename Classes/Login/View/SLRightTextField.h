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

