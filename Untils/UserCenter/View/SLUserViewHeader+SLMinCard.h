//
//  SLUserViewHeader+SLMinCard.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/5/5.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLUserViewHeader.h"

@interface SLUserViewHeader (SLMinCard)

- (instancetype)initWithFrame:(CGRect)frame Mincard:(BOOL)mincard;

- (void)adjustMiniCard ;

+(CGFloat)minCardHeightWithDesc:(NSString *)desc;

- (void)addBottomView;

- (void)clearData;

@end
