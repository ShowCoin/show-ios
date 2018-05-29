//
//  ChangeTextController.m
//  ShowLive
//
//  Created by vning on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ChangeTextController.h"
#import "SLUpdataUserInfoAction.h"
#import "SLTextView.h"
#define maxCount     100
@interface ChangeTextController ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,strong)SLTextView * inputTextView;
@property(nonatomic,strong)UIView * textFieldBackground;
@property(nonatomic,strong)UIButton * textStyleOne;
@property(nonatomic,strong)UIButton * textStyleTwo;
@property(nonatomic,copy)NSString * placeholderStr;
@property(nonatomic,assign)BOOL needTosave;
@property (nonatomic, strong) SLUpdataUserInfoAction *updataUserInfoAction;

@end

@implementation ChangeTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationTitle:self.navtitle];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
//    [self.navigationBarView setRightTitle:@"保存"];
    [self.navigationBarView setRightTitle:@"保存" titleColor:kThemeWhiteColor font:Font_Regular(15)];
    self.view.backgroundColor = kBlackThemeBGColor;
    switch (_type) {
        case textViewType_name:
            _placeholderStr = AccountUserInfoModel.nickname;
            break;
        case textViewType_city:
            _placeholderStr = AccountUserInfoModel.city;
            break;
        case textViewType_sign:
            _placeholderStr = AccountUserInfoModel.descriptions;
            break;
        default:
            break;
    }
    [self.view addSubview:self.textFieldBackground];
//    [self.view addSubview:self.textStyleOne];
//    [self.view addSubview:self.textStyleTwo];
    self.inputTextView.textAlignment = NSTextAlignmentCenter;


}
-(void)viewDidAppear:(BOOL)animated
{
    if (self.inputTextView) {
        [self.inputTextView becomeFirstResponder];

    }
}
- (void)clickRightButton:(UIButton *)sender{
    [self.inputTextView resignFirstResponder];
    [self updateUserInfo];
}
- (UIView*)textFieldBackground
{
    if (!_textFieldBackground) {
        _textFieldBackground = [[UIView alloc]init];
        _textFieldBackground.frame = CGRectMake(0, kNaviBarHeight, kMainScreenWidth, 260*Proportion375);
        _textFieldBackground.backgroundColor = kGrayWith999999;
        _textFieldBackground.layer.cornerRadius = 2;
        _textFieldBackground.layer.borderWidth = 0.5;
        _textFieldBackground.layer.borderColor = HexRGBAlpha(0xfffefe, .5).CGColor;
        [_textFieldBackground addSubview:self.inputTextView];
    }
    return _textFieldBackground;
}

-(SLTextView*)inputTextView
{
    if (!_inputTextView) {
        _inputTextView = [[SLTextView alloc]initWithFrame:CGRectMake(10, 0, kMainScreenWidth-40, 240)];
        _inputTextView.textColor = kBlackThemetextColor;
        _inputTextView.delegate = self;
        _inputTextView.backgroundColor = [UIColor clearColor];
//        _inputTextView.returnKeyType = UIReturnKeyDone;
        _inputTextView.keyboardType = UIKeyboardTypeDefault;
        _inputTextView.scrollEnabled = YES;
        _inputTextView.editable = YES;
        
        _inputTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _inputTextView.font = Font_Regular(14*Proportion375);
        _inputTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _inputTextView.keyboardAppearance = UIKeyboardAppearanceAlert;
        _inputTextView.tintColor = [UIColor blackColor];
        _inputTextView.textAlignment = NSTextAlignmentCenter;
        _inputTextView.text = [NSString stringWithFormat:@"%@",self.placeholderStr];
//        if ([NSString stringWithFormat:@"请输入%@",self.navtitle]) {
//            //    textview 改变字体的行间距
//
//            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//
//            paragraphStyle.lineSpacing = 5;// 字体的行间距
//
//
//
//            NSDictionary *attributes = @{
//
//                                         NSFontAttributeName:[UIFont systemFontOfSize:15],
//
//                                         NSParagraphStyleAttributeName:paragraphStyle
//
//                                         };
//
//            _inputTextView.attributedText = [[NSAttributedString alloc] initWithString:_inputTextView.text attributes:attributes];
//            //以上改变行间距
//        }
        _inputTextView.text = _placeholderStr;

//        [_inputTextView becomeFirstResponder];
    }
    
    return _inputTextView;
}
-(UIButton *)textStyleOne
{
    if (!_textStyleOne) {
        _textStyleOne = [UIButton buttonWithType:UIButtonTypeCustom];
        _textStyleOne.frame = CGRectMake(20*Proportion375, self.textFieldBackground.bottom, 44*Proportion375, 44*Proportion375);
        _textStyleOne.backgroundColor = [UIColor clearColor];
        [_textStyleOne setBackgroundImage:[UIImage imageNamed:@"userhome_des_type1"] forState:UIControlStateNormal];
        [[_textStyleOne rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            self.inputTextView.textAlignment = NSTextAlignmentLeft;
        }];
    }
    return _textStyleOne;
}
-(UIButton *)textStyleTwo
{
    if (!_textStyleTwo) {
        _textStyleTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        _textStyleTwo.frame = CGRectMake(self.textStyleOne.right + 20*Proportion375, self.textFieldBackground.bottom, 44*Proportion375, 44*Proportion375);
        _textStyleTwo.backgroundColor = [UIColor clearColor];
        [_textStyleTwo setBackgroundImage:[UIImage imageNamed:@"userhome_des_type2"] forState:UIControlStateNormal];
        [[_textStyleTwo rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            self.inputTextView.textAlignment = NSTextAlignmentCenter;

        }];
    }
    return _textStyleTwo;
}
#pragma  save methods
- (void)saveButtonClick:(UIButton*)sender
{
    //    NSString * trueStr = [self.inputTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * trueStr = [self.inputTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去首尾空格
    self.inputTextView.text = trueStr;
//    
//    if ( IsStrEmpty(self.inputTextView.text) ) {
//        
//        NSLog(@"save");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [ShowWaringView waringView:@"签名不能为空" style:WaringStyleRed];
//        });
//        
//    }
//    else
//    {
//        
//    }
    if ([self.inputTextView.text isEqualToString:AccountUserInfoModel.descriptions]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ShowWaringView waringView:@"你还没有修改哦~" style:WaringStyleGreen];
        });
        
    }else{
        [self updateUserInfo];
    }
    
}
#pragma textViewDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}
//- (void)textViewDidChange:(UITextView *)textView
//{
//    NSLog(@"==== = ====== %f",textView.contentSize.height);
//    _needTosave = YES;
//    //    //    textview 改变字体的行间距
//    //
//    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    //
//    //    paragraphStyle.lineSpacing = 5;// 字体的行间距
//    //
//    //
//    //
//    //    NSDictionary *attributes = @{
//    //
//    //                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
//    //
//    //                                 NSParagraphStyleAttributeName:paragraphStyle
//    //
//    //                                 };
//    //
//    //    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
//    //以上改变行间距
//    NSString *toBeString = _inputTextView.text;
//
//    NSLog(@" 打印信息toBeString:%@",toBeString);
//
//    NSString *lang = [[_inputTextView textInputMode] primaryLanguage]; // 键盘输入模式
//    if ([lang isEqualToString:@"zh-Hans"]||[lang isEqualToString:@"zh_CN"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
//
//        //判断markedTextRange是不是为Nil，如果为Nil的话就说明你现在没有未选中的字符，
//        //可以计算文字长度。否则此时计算出来的字符长度可能不正确
//
//        UITextRange *selectedRange = [_inputTextView markedTextRange];
//        //获取高亮部分(输入中文的时候才有)
//        UITextPosition *position = [_inputTextView positionFromPosition:selectedRange.start offset:0];
//        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//        if (!position)
//        {
//            //中文和字符一起检测  中文是两个字符
//            if ([toBeString getStringLenthOfBytes] > maxCount * 2)
//            {
//                _inputTextView.text = [toBeString subBytesOfstringToIndex:maxCount * 2];
//
//            }
//        }
//    }
//    else
//    {
//        if ([toBeString getStringLenthOfBytes] > maxCount)
//        {
//            _inputTextView.text = [toBeString subBytesOfstringToIndex:maxCount];
//        }
//    }
//
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    //内容（滚动视图）高度大于一定数值时
    NSLog(@"==== = ====== %f",textView.contentSize.height);
    NSLog(@"==== = ====== %f",200*Proportion375);
    _needTosave = YES;
    if (textView.contentSize.height >220*Proportion375)
    {
        //删除最后一行的第一个字符，以便减少一行。
        if (textView.text.length>=1) {
            textView.text = [textView.text substringToIndex:[textView.text length]-1];
            return NO;
        }
        return YES;
    }
    
    return YES;
}

- (void)updateUserInfo
{
    __weak typeof(self) weakSelf = self;
    _updataUserInfoAction = [SLUpdataUserInfoAction action];
//    switch (_type) {
//        case textViewType_name:
//            _updataUserInfoAction.nickname = self.inputTextView.text;
//            break;
//        case textViewType_city:
//            _updataUserInfoAction.city = self.inputTextView.text;
//            break;
//        case textViewType_sign:
//            break;
//        default:
//            break;
//    }
    _updataUserInfoAction.desc = self.inputTextView.text;
    @weakify(self)
    _updataUserInfoAction.finishedBlock = ^(id result) {
        @strongify(self)
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSLog(@"  response %@" ,result);
            self.block(self.inputTextView.text);
//            switch (self.type) {
//                case textViewType_name:
//                    AccountUserInfoModel.nickname = weakSelf.inputTextView.text;
//                    break;
//                case textViewType_city:
//                    AccountUserInfoModel.city = weakSelf.inputTextView.text;
//                    break;
//                case textViewType_sign:
////                    AccountUserInfoModel.description = weakSelf.inputTextField.text;
//                    break;
//                default:
//                    break;
//            }
            [[NSNotificationCenter defaultCenter]postNotificationName:kUserInfoChange object:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    _updataUserInfoAction.failedBlock = ^(NSError *error) {
        [ShowWaringView waringView:error.userInfo[@"msg"] style:WaringStyleRed];

    };
    [_updataUserInfoAction start];
    
}

-(void)clickLeftButton:(UIButton *)sender
{
    [self.inputTextView resignFirstResponder];
    if (_needTosave) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存修改" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"确认", nil];
        alert.delegate = self;
        [alert show];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self updateUserInfo];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
