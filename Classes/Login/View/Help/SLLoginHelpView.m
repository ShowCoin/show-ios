//
//  SLHelpView.m
//  Edu
//
//  Created by chenyh on 2018/9/7.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLLoginHelpView.h"

static NSString * const kSLHelpViewCellID = @"kSLHelpViewCellID";

@interface SLHelpViewCell : UITableViewCell

@end

@interface SLLoginHelpView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SLLoginHelpView

+ (instancetype)view {
    return [self alertView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.navigationView];
        [self.contentView addSubview:self.tableView];
        
        [self.navigationView addSubview:self.closeButton];
        self.contentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return self;
}


@end
