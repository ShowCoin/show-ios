//
//  SLPassWordAlert.m
//  ShowLive
//
//  Created by vning on 2018/7/27.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPassWordAlert.h"

@interface SLPassWordAlert ()<UITextFieldDelegate>

/** 密码的TextField */
@property (nonatomic, strong) UITextField *passwordTextField;
/** 黑点的个数 */
@property (nonatomic, strong) NSMutableArray *pointArr;
/** 输入安全密码的背景View */
@property (nonatomic, strong) UIView *BGView;

@end

// 密码点的大小
#define kPointSize CGSizeMake(10, 10)
// 密码个数
#define kPasswordCount 6
// 每一个密码框的高度
#define kBorderHeight 40
// 按钮的高度
#define kButtonHeight 49

@implementation SLPassWordAlert

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 背景颜色
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        // 输入安全密码的背景View
        UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake((kMainScreenWidth - 260*Proportion375) / 2, 0, 260*Proportion375, 230*Proportion375)];
        BGView.backgroundColor = [UIColor whiteColor];
        BGView.layer.cornerRadius = 6*Proportion375;
        BGView.layer.masksToBounds = YES;
        [self addSubview:BGView];
        self.BGView = BGView;
        BGView.center = self.center;
        
        CGFloat BGViewW = BGView.frame.size.width;
        CGFloat BGViewH = BGView.frame.size.height;
        // 请输入安全密码的Label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BGViewW, 50*Proportion375)];
        titleLabel.text = @"请输入资金密码";
        titleLabel.font = Font_Medium(18*Proportion375);
        [titleLabel setTextColor:kNavigationBGColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [BGView addSubview:titleLabel];
        
        // 取消按钮
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(10*Proportion375, 15*Proportion375, 20*Proportion375, 20*Proportion375);
        [cancelButton setImage:[UIImage imageNamed:@"home_wallet_alert_close"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [BGView addSubview:cancelButton];
        
        // 横线
        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49*Proportion375, BGViewW, 1)];
        topLineView.backgroundColor = kGrayWithd7d7d7;
        [BGView addSubview:topLineView];
        
        _cointypeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, topLineView.bottom + 29*Proportion375, BGViewW, 16*Proportion375)];
        _cointypeLab.text = @"秀币数量";
//        _cointypeLab.backgroundColor = kThemeRedColor;
        _cointypeLab.font = Font_Medium(16*Proportion375);
        [_cointypeLab setTextColor:kNavigationBGColor];
        _cointypeLab.textAlignment = NSTextAlignmentCenter;
        [BGView addSubview:_cointypeLab];

        _coinNumLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _cointypeLab.bottom+8*Proportion375, BGViewW, 30*Proportion375)];
        _coinNumLab.text = @"100";
//        _coinNumLab.backgroundColor = kThemeRedColor;
        _coinNumLab.font = Font_engBold(30*Proportion375);
        [_coinNumLab setTextColor:kNavigationBGColor];
        _coinNumLab.textAlignment = NSTextAlignmentCenter;
        [BGView addSubview:_coinNumLab];

        _coinRMBLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _coinNumLab.bottom + 6*Proportion375, BGViewW, 14*Proportion375)];
        _coinRMBLab.text = @"价值人民币";
//        _coinRMBLab.backgroundColor = kThemeRedColor;
        _coinRMBLab.font = Font_Regular(14*Proportion375);
        [_coinRMBLab setTextColor:kGrayWith676767];
        _coinRMBLab.textAlignment = NSTextAlignmentCenter;
        [BGView addSubview:_coinRMBLab];

        // 密码框
        CGFloat passwordTextFieldY = topLineView.bottom + 128*Proportion375;
        UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake((BGViewW - kPasswordCount * kBorderHeight) / 2, passwordTextFieldY, kPasswordCount * kBorderHeight, kBorderHeight)];
        passwordTextField.backgroundColor = [UIColor whiteColor];
        // 输入的文字颜色为白色
        passwordTextField.textColor = [UIColor whiteColor];
        // 输入框光标的颜色为白色
        passwordTextField.tintColor = [UIColor whiteColor];
        passwordTextField.delegate = self;
        passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        passwordTextField.layer.borderColor = kGrayWithd7d7d7.CGColor;
        passwordTextField.layer.borderWidth = 1;
        [passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [BGView addSubview:passwordTextField];
        // 页面出现时弹出键盘
        [passwordTextField becomeFirstResponder];
        self.passwordTextField = passwordTextField;
        
        // 生产分割线
        for (NSInteger i = 0; i < kPasswordCount - 1; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(passwordTextField.frame) + (i + 1) * kBorderHeight, CGRectGetMinY(passwordTextField.frame), 1, kBorderHeight)];
            lineView.backgroundColor = kGrayWithd7d7d7;
            [BGView addSubview:lineView];
        }
        
        self.pointArr = [NSMutableArray array];
        
        // 生成中间的点
        for (NSInteger i = 0; i < kPasswordCount; i++) {
            UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(passwordTextField.frame) + (kBorderHeight - kPointSize.width) / 2 + i * kBorderHeight, CGRectGetMinY(passwordTextField.frame) + (kBorderHeight - kPointSize.height) / 2, kPointSize.width, kPointSize.height)];
            pointView.backgroundColor = kNavigationBGColor;
            pointView.layer.cornerRadius = kPointSize.width / 2;
            pointView.layer.masksToBounds = YES;
            // 先隐藏
            pointView.hidden = YES;
            [BGView addSubview:pointView];
            // 把创建的黑点加入到数组中
            [self.pointArr addObject:pointView];
        }
        
        // 监听键盘的高度
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    NSLog(@"变化%@", string);
    if ([string isEqualToString:@"\n"]) {
        // 按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if (string.length == 0) {
        // 判断是不是删除键
        return YES;
    } else if (textField.text.length >= kPasswordCount) {
        // 输入的字符个数大于6
        //        NSLog(@"输入的字符个数大于6,忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 清除密码
 */
- (void)clearUpPassword {
    
    self.passwordTextField.text = @"";
    [self textFieldDidChange:self.passwordTextField];
}

/**
 重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField {
    //    NSLog(@"%@", textField.text);
    for (UIView *pointView in self.pointArr) {
        pointView.hidden = YES;
    }
    for (NSInteger i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.pointArr objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kPasswordCount) {
        //        NSLog(@"输入完毕,密码为%@", textField.text);
        [self sureButtonAction];
        
    }
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self endEditing:YES];
}

#pragma mark - 按钮的执行方法
// 取消按钮
- (void)cancelButtonAction {
    
    [self removeFromSuperview];
}

// 确定按钮
- (void)sureButtonAction {
    
    if ([self.delegate respondsToSelector:@selector(sureActionWithAlertPasswordView:password:)]) {
        [self.delegate sureActionWithAlertPasswordView:self password:self.passwordTextField.text];
    }
}

#pragma mark - 键盘的出现和收回的监听方法
- (void)keyboardWillShow:(NSNotification *)aNotification {
    // 获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    self.BGView.frame = CGRectMake(self.BGView.frame.origin.x, kMainScreenHeight - keyboardHeight - self.BGView.frame.size.height - 30, self.BGView.frame.size.width, self.BGView.frame.size.height);
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    self.BGView.center = CGPointMake(self.BGView.center.x, self.center.y);
}


@end
