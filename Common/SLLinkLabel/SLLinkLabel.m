//
//  SLLinkLabel.m
//  ShowLive
//
//  Created by vning on 2018/5/31.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLinkLabel.h"

@implementation SLLinkLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addCopyForLabel];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self addCopyForLabel];
}




@end
