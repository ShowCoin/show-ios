//
//  SLRPResultCell.m
//  demoPro
//
//  Created by chenyh on 2018/7/31.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLRPResultCell.h"
#import "SLHeadPortrait.h"
#import "SLLevelMarkView.h"

CGFloat const kSLRPResultCellH = 60;
CGFloat const kRPMargin = 18;
static CGFloat const kHeaderViewWH = 30;

static inline CGSize SLFuncGetAttributeStringSize(CGFloat labelW, NSAttributedString *text) {
    return [text boundingRectWithSize:CGSizeMake(labelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}

@interface SLRPResultCell ()

@end
