//
//  SLLinkLabel.h
//  ShowLive
//
//  Created by vning on 2018/5/31.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZSelectableLabel.h"
#import "UIColor+Equalable.h"

@interface SLLinkLabel : MZSelectableLabel
- (void)urlAndIphoneValidation:(NSString *)string;
@end

