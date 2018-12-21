//
//  SLHeadPortrait.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLHeadPortrait.h"
#import "NSString+Validation.h"
@interface SLHeadPortrait()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation SLHeadPortrait

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        vipWidth = self.size.width *0.45;
        vipHeight = self.size.height * 0.7;
        vipLeft  =self.size.width*0.55;
        vipTop  =self.size.width*0.3;
        [self addloadView];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        vipWidth = self.size.width *0.45;
        vipHeight = self.size.height * 0.7;
        vipLeft  =self.size.width*0.55;
        vipTop  =self.size.width*0.3;
        [self addloadView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
