//
//  SLSearchBar.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLSearchBar.h"
#import "SLSearchTextField.h"

NS_ASSUME_NONNULL_BEGIN
static const CGFloat SLSearchBarHeight = 44;
static const CGFloat SLTextFieldHeight = 28;
#define SLSearchBarMargin 15*Proportion375

@interface SLSearchBar ()<UITextFieldDelegate>
/** 1.输入框 */
@property (nonatomic, strong) SLSearchTextField *textField;
/** 2.取消按钮 */
@property (nonatomic, strong) UIButton *buttonCancel;
/** 3.搜索图标 */
@property (nonatomic, strong) UIImageView *imageIcon;
/** 4.中间视图 */
@property (nonatomic, strong) UIButton *buttonCenter;

@end
NS_ASSUME_NONNULL_END
@implementation SLSearchBar
#pragma mark - --- 1. init 视图初始化 ---
- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

@end
