//
//  SLUserInfoViewController.m
//  ShowLive
//
//  Created by vning on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLUserInfoViewController.h"
#import "SLInfoHeaderView.h"
#import "SLUserInfoListCell.h"
#import "ShowUserQRViewController.h"
#import "SLUpdataUserInfoAction.h"
#import "ChangeTextController.h"
#import "SLHelper.h"
@interface SLUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIButton *close;
    UIButton *sureBotton;
    NSArray * percentArr;
    NSArray * citysArray;
    NSArray * characterArray;
}
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UITextField * nameTextField;
@property (strong, nonatomic) UITextField * IDTextField;
@property (nonatomic, strong) UIActionSheet * userSexActionSheet;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView * PercentpickerView;

@property (nonatomic, assign) NSInteger  characterIndex;
@property (nonatomic, assign) NSInteger  cityIndex;
@property (nonatomic, strong) UIView *  bgView;
@property (nonatomic, strong) UIButton *bg;




@property (assign,nonatomic)BOOL nicknameChanged;
@property (assign,nonatomic)BOOL popNumberChanged;
@property (assign,nonatomic)BOOL genderChanged;
@property (assign,nonatomic)BOOL birthdayChanged;
@property (assign,nonatomic)BOOL cityChanged;
@property (assign,nonatomic)BOOL descriptionsChanged;
@property (assign,nonatomic)BOOL extractChanged;//分成比例设置
@property (assign,nonatomic)BOOL operation_extractChanged;//运营分成摄者

@property (copy,nonatomic)NSString * nickname;
@property (copy,nonatomic)NSString * popNumber;
@property (copy,nonatomic)NSString * gender;
@property (copy,nonatomic)NSString * birthday;
@property (copy,nonatomic)NSString * city;
@property (copy,nonatomic)NSString * descriptions;
@property (copy,nonatomic)NSString * extract;//分成比例设置
@property (copy,nonatomic)NSString * operation_extract;//运营分成摄者
@property (assign,nonatomic)BOOL  canUpload;//可以上传

@property (nonatomic, strong) SLUpdataUserInfoAction *updataUserInfoAction;

@end

@implementation SLUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setRightTitle:@"保存"titleColor:kThemeWhiteColor font:Font_Regular(14)];
    [self.navigationBarView setNavigationTitle:@"个人资料"];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    
    [self initParameter];
    
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.navigationBarView];
    self.view.backgroundColor = kBlackThemeBGColor;
    percentArr = [NSArray arrayWithObjects:@"0",@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100", nil];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    citysArray = [[NSArray alloc] initWithContentsOfFile:path];
    characterArray  = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z", nil];
    _characterIndex = 0;
    _cityIndex = 0;
    _canUpload = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

-(void)initParameter
{
    self.nickname = [NSString stringWithFormat:@"%@",AccountUserInfoModel.nickname];
    self.popNumber = AccountUserInfoModel.popularNo;
    self.gender = AccountUserInfoModel.gender;
    self.birthday = AccountUserInfoModel.birthday;
    self.city = AccountUserInfoModel.city;
    self.descriptions = AccountUserInfoModel.descriptions;
    self.extract = AccountUserInfoModel.extract;
    self.operation_extract = AccountUserInfoModel.operation_extract;

}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =kBlackThemeBGColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        } else {
            
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (UITextField*)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(90*Proportion375,25, 250*Proportion375,52)];
        //        _inputTextField.type = 1;
        _nameTextField.centerY = 26*Proportion375;
        //        _textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.];
        _nameTextField.backgroundColor = [UIColor clearColor];
        _nameTextField.font = Font_Regular(15);
        _nameTextField.clearButtonMode = UITextFieldViewModeNever;
        _nameTextField.contentVerticalAlignment =UIControlContentHorizontalAlignmentCenter;
        _nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.returnKeyType = UIReturnKeyDone;
        _nameTextField.delegate = self;
        _nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _nameTextField.textColor = kBlackThemetextColor;
        _nameTextField.tintColor = kBlackThemetextColor;
        [_nameTextField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
//        UIButton *clean = [_nameTextField valueForKey:@"_clearButton"]; //key是固定的
//        [clean setImage:[UIImage imageNamed:@"name_cleanbtn"] forState:UIControlStateNormal];
//        [clean setImage:[UIImage imageNamed:@"name_cleanbtn"] forState:UIControlStateHighlighted];

    }
    return _nameTextField;
    
}
- (UITextField*)IDTextField
{
    if (!_IDTextField) {
        _IDTextField = [[UITextField alloc]initWithFrame:CGRectMake(90*Proportion375,25, 250*Proportion375,15*Proportion375)];
        _IDTextField.centerY = 26*Proportion375;
        _IDTextField.backgroundColor = [UIColor clearColor];
        _IDTextField.font = Font_Regular(15*Proportion375);
        _IDTextField.clearButtonMode = UITextFieldViewModeNever;
        _IDTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _IDTextField.keyboardType = UIKeyboardTypeDefault;
        _IDTextField.returnKeyType = UIReturnKeyDone;
        _IDTextField.delegate = self;
        _IDTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _IDTextField.textColor = kBlackThemetextColor;
        _IDTextField.tintColor = kBlackThemetextColor;
        [_IDTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _IDTextField.userInteractionEnabled = NO;
        _IDTextField.enabled = NO;
    }
    return _IDTextField;
    
}

-(UIActionSheet*)userSexActionSheet
{
    if (!_userSexActionSheet) {
        _userSexActionSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        _userSexActionSheet.delegate = self;
        _userSexActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        _userSexActionSheet.tag = 9001;
        
    }
    return _userSexActionSheet;
}
-(void)initPickerWithType:(NSInteger)type
{
    if (!_PercentpickerView) {
        _PercentpickerView = [[UIPickerView alloc] init];
        _PercentpickerView.frame = CGRectMake(0,kMainScreenHeight, kMainScreenWidth, 185);
        _PercentpickerView.dataSource = self;
        _PercentpickerView.delegate = self;
        _PercentpickerView.showsSelectionIndicator = YES;
        _PercentpickerView.backgroundColor= kThemeWhiteColor;
    }
    if (type == 1) {
        _PercentpickerView.tag = 1000;

    }else{
        _PercentpickerView.tag = 2000;

    }
    self.bg = [[UIButton alloc] initWithFrame:self.view.frame];
    [self.bg addTarget:self action:@selector(dissappaerAction) forControlEvents:UIControlEventTouchUpInside];
    self.bg.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    [self.bg addSubview:_PercentpickerView];
    self.bg.alpha = 0;
    [self.view addSubview:self.bg];
    [UIView animateWithDuration:0.25 animations:^{
        self.bg.alpha = 1;
        self.PercentpickerView.top = kMainScreenHeight - 185;
    }];
    
}
- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker   = [[UIDatePicker alloc] init];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.backgroundColor = [UIColor whiteColor];
        // UIDatePicker默认高度216
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.frame = CGRectMake(0, 0 ,kMainScreenWidth, _datePicker.height);
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:-18];
        
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        [comps setYear:-99];
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
        
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate*date=[formatter dateFromString:AccountUserInfoModel.birthday];
        if (date!=nil) {
            [_datePicker setDate:date];
        }
        else
        {
            [_datePicker setDate:[formatter dateFromString:@"1990-01-01"]];
        }
        [_datePicker setMaximumDate:maxDate];
        [_datePicker setMinimumDate:minDate];
    }
    return _datePicker;
}
-(void)changeBirthday
{
    self.bg = [[UIButton alloc] initWithFrame:self.view.frame];
    [self.bg addTarget:self action:@selector(birthDaySure) forControlEvents:UIControlEventTouchUpInside];
    self.bg.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    self.bg.alpha = 0;
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0,kMainScreenHeight - 216, kMainScreenWidth, 216)];
    self.bgView.top = kMainScreenHeight;
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.bgView cornerRadiusStyle];
    [self.bg addSubview:self.bgView];
    
//    close = [[UIButton alloc] initWithFrame:CGRectMake(0, self.datePicker.bottom, 153*Proportion375, 52)];
//    [close setTitle:@"取消" forState:UIControlStateNormal];
//    [close lineDockTopWithColor:kSeparationColor];
//    [close setTitleColor :kthemeBlackColor forState:UIControlStateNormal];
//    [close addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
//
//    sureBotton = [[UIButton alloc] initWithFrame:CGRectMake(153*Proportion375, _datePicker.bottom, 153*Proportion375, 52)];
//    [sureBotton setTitle:@"确定" forState:UIControlStateNormal];
//    [sureBotton setTitleColor :kthemeBlackColor forState:UIControlStateNormal];
//    [sureBotton lineDockTopWithColor:kSeparationColor];
//    [sureBotton lineDockLeftWithColor:kSeparationColor];
//    [sureBotton addTarget:self action:@selector(sureView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.bg];
    [self.bgView addSubview:self.datePicker];
    @weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        self.bg.alpha = 1;
        self.bgView.top = kMainScreenHeight - 216;
    }];
}

- (void)dissappaerAction{
    [self sureView];
}
-(void)sureView
{
    [self closeView];
}
-(void)birthDaySure
{
    NSDate *select = self.datePicker.date;
    NSDateFormatter *dateFormmater = [[NSDateFormatter alloc]init];
    [dateFormmater setDateFormat:@"yyyy-MM-dd"];
    self.birthday = [dateFormmater stringFromDate:select];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    [self closeView];

}
-(void)closeView{
    if (self.bg) {
        [UIView animateWithDuration:0.25 animations:^{
            if (self.bgView) {
                self.bgView.top = kMainScreenHeight;
            }
            if (self.PercentpickerView) {
                self.PercentpickerView.top = kMainScreenHeight;
            }
        } completion:^(BOOL finished) {
        
            [UIView animateWithDuration:0.25 animations:^{
                self.bg.alpha = 0;
            } completion:^(BOOL finished) {
                
                if (self.datePicker) {
                    [self.datePicker removeFromSuperview];
                    self.datePicker = nil;
                }
                if (self.PercentpickerView) {
                    [self.PercentpickerView removeFromSuperview];
                    self.PercentpickerView = nil;
                }
                
                [self.bg removeFromSuperview];
                self.bg = nil;
            }];
        }];

    }
}

#pragma mark - delegates
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        SLInfoHeaderView * header = [[SLInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 230*Proportion375)];
        [header.avaImg yy_setImageWithURL:[NSURL URLWithString:AccountUserInfoModel.avatar] placeholder:[UIImage imageNamed:@""]];
        [header.BgImgView yy_setImageWithURL:[NSURL URLWithString:AccountUserInfoModel.large_avatar] placeholder:[UIImage imageNamed:@""]];
        return header;
    }else{
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 12*Proportion375)];
        UIView * line =[[UIView alloc] initWithFrame:CGRectMake(0, 11*Proportion375, kMainScreenWidth, 1)];
        line.backgroundColor = kBlackThemeColor;
        [view addSubview:line];
        return view;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 230*Proportion375;
    }
    return 12*Proportion375;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01 ;
    }
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 7;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
 }
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"UserInfoListCell";
    SLUserInfoListCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
        cell = [[SLUserInfoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.title.text = @"名称";
                cell.title.textColor = kGrayWith999999;
                [cell addSubview:self.nameTextField];
                self.nameTextField.text = self.nickname;
                cell.detailTextLab.hidden = NO;
                cell.detailTextLab.text = @"昵称不能超过8个字符，并且只能修改一次";
                break;
            case 1:
                cell.title.text = @"秀号";
                cell.title.textColor = kGrayWith999999;
                [cell addSubview:self.IDTextField];
                self.IDTextField.text = self.popNumber;
                break;
            case 2:
                cell.title.text = @"性别";
                cell.title.textColor = kGrayWith999999;
                cell.textLab.hidden = NO;
                cell.textLab.text = self.gender.integerValue == 1?@"男":@"女";
                cell.textLab.textColor = kBlackThemetextColor;
                break;
            case 3:
                cell.title.text = @"生日";
                cell.title.textColor = kGrayWith999999;
                cell.textLab.hidden = NO;
                cell.textLab.text = self.birthday;
                cell.textLab.textColor = kBlackThemetextColor;

                break;
            case 4:
                cell.title.text = @"地区";
                cell.title.textColor = kGrayWith999999;
                cell.textLab.hidden = NO;
                cell.textLab.text = self.city;
                cell.textLab.textColor = kBlackThemetextColor;

                break;
            case 5:
                cell.title.text = @"签名";
                cell.title.textColor = kGrayWith999999;
                cell.arrow.hidden = NO;
                cell.textLab.hidden = NO;
                cell.textLab.text = self.descriptions;
                cell.textLab.textColor = kBlackThemetextColor;

                break;
            case 6:
                cell.title.text = @"我的二维码";
                cell.title.textColor = kGrayWith999999;
                cell.arrow.hidden = NO;

                break;
        
            default:
                break;
                
        }
        
    }else{
        switch (indexPath.row) {
            case 0:
                cell.title.text = @"分成比例设置";
                cell.title.textColor = kGrayWith999999;
                cell.arrow.hidden = NO;
                cell.textLab.hidden = NO;
                cell.textLab.text = [NSString stringWithFormat:@"       %@%@",self.extract,@"%"];
                cell.textLab.textColor = kBlackThemetextColor;

                break;
//            case 1:
//                cell.title.text = @"运营分层设置";
//                cell.title.textColor = kthemeBlackColor;
//                cell.arrow.hidden = NO;
//                cell.textLab.hidden = NO;
//                cell.textLab.text = [NSString stringWithFormat:@"       %@%@",self.operation_extract,@"%"];
//                cell.textLab.textColor = kthemeBlackColor;
//
//                break;
            default:
                break;
        }
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.nameTextField isFirstResponder]) {
        [self.nameTextField resignFirstResponder];
        return;
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                break;
            case 1:
            
                break;
            case 2:
                
                [self.userSexActionSheet showInView:self.view];
                break;
            case 3:
                [self.nameTextField resignFirstResponder];
                [self changeBirthday];
                break;
            case 4:
                [self initPickerWithType:2];

                break;
            case 5:
            {
                ChangeTextController * F = [ChangeTextController initVC];
                F.navtitle = @"签名";
                F.type = textViewType_sign;
                F.block = ^(NSString *changeText) {
                    AccountUserInfoModel.descriptions = changeText;
                    self.descriptions = changeText;
                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:5 inSection:0],nil] withRowAnimation:NO];
                };
                
                [self.navigationController pushViewController:F animated:YES];
            }

                break;
            case 6:
                [self.navigationController pushViewController:[ShowUserQRViewController initVC] animated:YES];
                break;
                
            default:
                break;
                
        }
        
    }else{
        switch (indexPath.row) {
            case 0:
                [self initPickerWithType:1];
                break;
            case 1:
                [self initPickerWithType:1];
                break;
            default:
                break;
        }
        
    }
}
#pragma mark - textField
-(void)textDidChanged:(UITextField *)textField
{
    self.nicknameChanged = YES;
    NSString * str =  textField.text;
    BOOL isOrNo = [SLHelper isAvailableName:str];
    NSLog(@"===================%@",isOrNo?@"yes":@"no");
    self.nickname = textField.text;
    if (isOrNo) {
        _canUpload = YES;
    }else{
        _canUpload = NO;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

#pragma mark - delegates

- (void)textFieldDidChange:(id)sender {
    
    
    if (sender == self.nameTextField) {
        
        NSString *toBeString = self.nameTextField.text;
        
        NSLog(@" 打印信息toBeString:%@",toBeString);
        
        NSString *lang = [[self.nameTextField textInputMode] primaryLanguage]; // 键盘输入模式
        if ([lang isEqualToString:@"zh-Hans"]||[lang isEqualToString:@"zh_CN"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            
            //判断markedTextRange是不是为Nil，如果为Nil的话就说明你现在没有未选中的字符，
            //可以计算文字长度。否则此时计算出来的字符长度可能不正确
            
            UITextRange *selectedRange = [self.nameTextField markedTextRange];
            //获取高亮部分(感觉输入中文的时候才有)
            UITextPosition *position = [self.nameTextField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position)
            {
                //中文和字符一起检测  中文是两个字符
                if ([toBeString getStringLenthOfBytes] > 24)
                {
                    self.nameTextField.text = [toBeString subBytesOfstringToIndex:24];
                }
            }
        }
        else
        {
            if ([toBeString getStringLenthOfBytes] > 24)
            {
                self.nameTextField.text = [toBeString subBytesOfstringToIndex:24];
            }
        }
        if ([AccountUserInfoModel.nickname isEqualToString:self.nameTextField.text]) {
            _nicknameChanged = NO;
        }else{
            self.nickname = [NSString stringWithFormat:@"%@",self.nameTextField.text];
            _nicknameChanged = YES;
        }
    }else if (sender == self.IDTextField){
        
        NSString *toBeString = self.IDTextField.text;
        
        NSLog(@" 打印信息toBeString:%@",toBeString);
        
        NSString *lang = [[self.IDTextField textInputMode] primaryLanguage]; // 键盘输入模式
        if ([lang isEqualToString:@"zh-Hans"]||[lang isEqualToString:@"zh_CN"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            
            //判断markedTextRange是不是为Nil，如果为Nil的话就说明你现在没有未选中的字符，
            //可以计算文字长度。否则此时计算出来的字符长度可能不正确
            
            UITextRange *selectedRange = [self.IDTextField markedTextRange];
            //获取高亮部分(感觉输入中文的时候才有)
            UITextPosition *position = [self.IDTextField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position)
            {
                //中文和字符一起检测  中文是两个字符
                if ([toBeString getStringLenthOfBytes] > 24)
                {
                    self.IDTextField.text = [toBeString subBytesOfstringToIndex:24];
                }
            }
        }
        else
        {
            if ([toBeString getStringLenthOfBytes] > 24)
            {
                self.IDTextField.text = [toBeString subBytesOfstringToIndex:24];
            }
        }
        if ([AccountUserInfoModel.popularNo isEqualToString:self.IDTextField.text]) {
            _popNumberChanged = NO;
        }else{
            self.popNumber = [NSString stringWithFormat:@"%@",self.IDTextField.text];
            _popNumberChanged = YES;
        }
    }
    NSString *toBeString = self.nameTextField.text;
    
    NSLog(@" 打印信息toBeString:%@",toBeString);

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 9001:{
            switch (buttonIndex) {
                case 0:
                    self.gender = @"1";
                    break;
                case 1:
                    self.gender = @"2";
                    break;
                default:
                    break;
            }
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 9002:
            break;

        default:
            break;
    }
}
#pragma mark picker view delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView.tag == 1000) {
        return 1;
    }else{
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 1000) {
        
        return percentArr.count;
    }else{
        if (component == 0) {
            return characterArray.count;
        }else{
            return [NSArray arrayWithArray:[citysArray objectAtIndex:_characterIndex]].count;
        }
    }
    return 0;
}

//- (NSString *)pickerView:(UIPickerView *)pickerView
//             titleForRow:(NSInteger)row
//            forComponent:(NSInteger)component
//{
//    NSString *titleStr;
//    if (row < 60) {
//
//        titleStr =  [NSString stringWithFormat:@"%@ cm",[_constellationArray objectAtIndex:row]];
//    }else{
//        titleStr =  [_constellationArray objectAtIndex:row];
//
//    }
//
//    return titleStr;
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    //设置分割线的颜色
    
    for(UIView *singleLine in pickerView.subviews)
        
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = kSeparationColor;
        }
    }
    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.textColor = kthemeBlackColor;
    NSString *titleStr;
    if (pickerView.tag == 1000) {
        
        titleStr = [NSString stringWithFormat:@"%@%@",[percentArr objectAtIndex:row],@"%"];
        genderLabel.text = titleStr;
    }else{
        if (component == 0) {
            
            titleStr = [NSString stringWithFormat:@"%@",[characterArray objectAtIndex:row]];
            genderLabel.text = titleStr;
        }else{
            titleStr = [NSString stringWithFormat:@"%@",[[citysArray objectAtIndex:_characterIndex] objectAtIndex:row]];
            genderLabel.text = titleStr;

        }

    }
    return genderLabel;
//    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 1000) {
        self.extract= [percentArr objectAtIndex:row];
        NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path,nil] withRowAnimation:NO];
        
    }else{
        if (component == 0) {
            _characterIndex = row;
            _cityIndex = 0;
            [_PercentpickerView reloadComponent:1];
            self.city = [[citysArray objectAtIndex:_characterIndex] objectAtIndex:0];
            NSIndexPath * path = [NSIndexPath indexPathForRow:4 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path,nil] withRowAnimation:NO];

        }else{
            _cityIndex = row;
            self.city = [[citysArray objectAtIndex:_characterIndex] objectAtIndex:row];
            NSIndexPath * path = [NSIndexPath indexPathForRow:4 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path,nil] withRowAnimation:NO];

        }
        [self resetPickerSelectRow];
    }
}
-(void)resetPickerSelectRow
{
    [self.PercentpickerView selectRow:_characterIndex inComponent:0 animated:YES];
    [self.PercentpickerView selectRow:_cityIndex inComponent:1 animated:YES];
}
#pragma mark - actions
- (void)clickRightButton:(UIButton *)sender;
{
    if (!_canUpload) {
        [HDHud showMessageInView:self.view  title:@"昵称不能超过8个字符"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    _updataUserInfoAction = [SLUpdataUserInfoAction action];
    if (_nicknameChanged) {
        _updataUserInfoAction.nickname = self.nickname;
    }
    if (_popNumberChanged) {
        _updataUserInfoAction.popularNo = self.popNumber;
    }
    if (![AccountUserInfoModel.gender isEqualToString:self.gender]) {
        _genderChanged = YES;
        _updataUserInfoAction.gender = self.gender;
    }
    if (![AccountUserInfoModel.birthday isEqualToString:self.birthday]) {
        _birthdayChanged = YES;
        _updataUserInfoAction.birthday = [NSString stringWithFormat:@"%@",self.birthday];
    }
    if (![AccountUserInfoModel.city isEqualToString:self.city]) {
        _cityChanged = YES;
        _updataUserInfoAction.city = self.city;
    }
    if (![AccountUserInfoModel.extract isEqualToString:self.extract]) {
        _extractChanged = YES;
        _updataUserInfoAction.extract = self.extract;
    }
    if (_nicknameChanged == NO &&_popNumberChanged == NO &&_genderChanged == NO &&_birthdayChanged == NO &&_cityChanged == NO &&_extractChanged == NO) {
        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
//    _updataUserInfoAction.operation_extract = AccountUserInfoModel.operation_extract;

    _updataUserInfoAction.finishedBlock = ^(id result) {
        if (weakSelf.nicknameChanged) {
            AccountUserInfoModel.nickname = weakSelf.nickname;
        }
        if (weakSelf.popNumberChanged) {
            AccountUserInfoModel.popularNo = weakSelf.popNumber;
        }
        if (weakSelf.genderChanged) {
            AccountUserInfoModel.gender = weakSelf.gender;
        }
        if (weakSelf.birthdayChanged) {
            AccountUserInfoModel.birthday = weakSelf.birthday;
        }
        if (weakSelf.cityChanged) {
            AccountUserInfoModel.city = weakSelf.city;
        }
        if (weakSelf.extractChanged) {
            AccountUserInfoModel.extract = weakSelf.extract;
        }
        [AccountUserInfoModel save];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
//    @weakify(self);
    _updataUserInfoAction.failedBlock = ^(NSError *error) {
//        @strongify(self);
        
        [ShowWaringView waringView:error.userInfo[@"msg"] style:WaringStyleRed];

    };
    [_updataUserInfoAction start];

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
