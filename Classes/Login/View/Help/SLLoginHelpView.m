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

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    CGFloat viewW = w * 0.6;
    CGFloat viewX = w - viewW;
    CGFloat viewY = 0;
    CGFloat viewH = h;
    self.contentView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    viewX = 0;
    viewH = KNaviBarHeight;
    self.navigationView.frame = CGRectMake(viewX, viewY, viewW, viewH);

    viewY = CGRectGetMaxY(self.navigationView.frame);
    viewH = CGRectGetHeight(self.contentView.frame) - viewY;
    self.tableView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    viewH = 44;
    viewW = 44;
    viewX = CGRectGetWidth(self.navigationView.frame) - viewW;
    viewY = CGRectGetHeight(self.navigationView.frame) - viewH;
    self.closeButton.frame = CGRectMake(viewX, viewY, viewW, viewH);
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kSLHelpViewCellID];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(SLHelpViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = @"如何获取正确推荐人?";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Method

- (void)showView {
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    
    self.alpha = 0;
    self.contentView.mj_x = kScreenWidth;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1;
        self.contentView.mj_x = kScreenWidth * 0.4;
    } completion:nil];
}

- (void)hideViewHandler:(SLSimpleBlock)handler {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0.1;
        self.contentView.mj_x = kScreenWidth;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (handler) {
            handler();
        }
    }];
}

- (void)closeAction {
    [self hideViewHandler:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self closeAction];
}


@end
