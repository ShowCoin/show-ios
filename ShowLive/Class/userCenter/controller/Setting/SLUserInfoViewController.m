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
@interface SLUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIButton *bg;
    UIView *bgView;
    UIButton *close;
    UIButton *sureBotton;
    NSArray * percentArr;
}
@property(strong,nonatomic)UITableView * tableView;
@property (strong,nonatomic)UITextField * nameTextField;
@property (strong,nonatomic)UITextField * IDTextField;
@property (nonatomic,strong)UIActionSheet * userSexActionSheet;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView * PercentpickerView;

@property (strong,nonatomic)NSString * nickname;
@property (strong,nonatomic)NSString * popNumber;
@property (strong,nonatomic)NSString * gender;
@property (strong,nonatomic)NSString * birthday;
@property (strong,nonatomic)NSString * area;
@property (strong,nonatomic)NSString * descriptions;
@property (strong,nonatomic)NSString * Mypercent;//分成比例设置
@property (strong,nonatomic)NSString * Compercent;//运营分成摄者

@property (nonatomic, strong) SLUpdataUserInfoAction *updataUserInfoAction;

@end

@implementation SLUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setRightTitle:@"保存"titleColor:kThemeWhiteColor font:Font_Regular(14)];
    [self.navigationBarView setNavigationTitle:@"个人资料"];
    [self.navigationBarView setNavigationColor:NavigationColorClear];
    
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.navigationBarView];
    self.view.backgroundColor = kThemeWhiteColor;
    percentArr = [NSArray arrayWithObjects:@"0",@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100", nil];
    
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =kThemeWhiteColor;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        } else {
            
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _tableView;
}

- (UITextField*)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(90*Proportion375,25, 250*Proportion375,15*Proportion375)];
        //        _inputTextField.type = 1;
        _nameTextField.centerY = 26*Proportion375;
        //        _textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.];
        _nameTextField.backgroundColor = [UIColor clearColor];
        _nameTextField.font = Font_Regular(15*Proportion375);
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.returnKeyType = UIReturnKeyDone;
        _nameTextField.delegate = self;
        _nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _nameTextField.textColor = kthemeBlackColor;
        _nameTextField.tintColor = kthemeBlackColor;
        [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
        _IDTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _IDTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _IDTextField.keyboardType = UIKeyboardTypeDefault;
        _IDTextField.returnKeyType = UIReturnKeyDone;
        _IDTextField.delegate = self;
        _IDTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _IDTextField.textColor = kthemeBlackColor;
        _IDTextField.tintColor = kthemeBlackColor;
        [_IDTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
-(void)initPicker
{
    if (!_PercentpickerView) {
        _PercentpickerView = [[UIPickerView alloc] init];
        _PercentpickerView.frame = CGRectMake(0,kMainScreenHeight-185, kMainScreenWidth, 185);
        _PercentpickerView.dataSource = self;
        _PercentpickerView.delegate = self;
        _PercentpickerView.showsSelectionIndicator = YES;
        _PercentpickerView.backgroundColor= kThemeWhiteColor;
        
        bg = [[UIButton alloc] initWithFrame:self.view.frame];
        [bg addTarget:self action:@selector(dissappaerAction) forControlEvents:UIControlEventTouchUpInside];
        bg.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];

        [bg addSubview:_PercentpickerView];
        [self.view addSubview:bg];
    }
}- (UIDatePicker *)datePicker
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
    bg = [[UIButton alloc] initWithFrame:self.view.frame];
    [bg addTarget:self action:@selector(dissappaerAction) forControlEvents:UIControlEventTouchUpInside];
    bg.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0,kMainScreenHeight - 216, kMainScreenWidth, 216)];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView cornerRadiusStyle];
    [bg addSubview:bgView];
    
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
    
    [self.view addSubview:bg];
    [bgView addSubview:self.datePicker];
    
}

- (void)dissappaerAction{
    [self sureView];
}
-(void)sureView
{
    NSDate *select = self.datePicker.date;
    NSDateFormatter *dateFormmater = [[NSDateFormatter alloc]init];
    [dateFormmater setDateFormat:@"yyyy-MM-dd"];
    [self closeView];
    AccountUserInfoModel.birthday = [dateFormmater stringFromDate:select];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)closeView{
    if (_datePicker) {
        
        [_datePicker removeFromSuperview];
    }
    if (_PercentpickerView) {
        [_PercentpickerView removeFromSuperview];
    }
    if (bg) {
        [bg removeFromSuperview];
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
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 7;
    }
    return 2;
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
                self.nameTextField.text = AccountUserInfoModel.nickname;
                break;
            case 1:
                cell.title.text = @"ID";
                cell.title.textColor = kGrayWith999999;
                [cell addSubview:self.IDTextField];
                self.IDTextField.text = AccountUserInfoModel.popularNo;
                cell.detailTextLab.hidden = NO;
                cell.detailTextLab.text = @"只允许包含字母，数字，下划线和点，且只能修改一次";
                break;
            case 2:
                cell.title.text = @"性别";
                cell.title.textColor = kGrayWith999999;
                cell.textLab.hidden = NO;
                cell.textLab.text = AccountUserInfoModel.gender.integerValue == 1?@"男":@"女";
                cell.textLab.textColor = kthemeBlackColor;
                break;
            case 3:
                cell.title.text = @"生日";
                cell.title.textColor = kGrayWith999999;
                cell.textLab.hidden = NO;
                cell.textLab.text = AccountUserInfoModel.birthday;
                cell.textLab.textColor = kthemeBlackColor;

                break;
            case 4:
                cell.title.text = @"地区";
                cell.title.textColor = kGrayWith999999;
                cell.textLab.hidden = NO;
                cell.textLab.text = AccountUserInfoModel.city;
                cell.textLab.textColor = kthemeBlackColor;

                break;
            case 5:
                cell.title.text = @"签名";
                cell.title.textColor = kGrayWith999999;
                cell.arrow.hidden = NO;
                cell.textLab.hidden = NO;
                cell.textLab.text = AccountUserInfoModel.descriptions;
                cell.textLab.textColor = kGrayWith999999;

                break;
            case 6:
                cell.title.text = @"我的二维码";
                cell.title.textColor = kthemeBlackColor;
                cell.arrow.hidden = NO;

                break;
        
            default:
                break;
                
        }
        
    }else{
        switch (indexPath.row) {
            case 0:
                cell.title.text = @"分成比例设置";
                cell.title.textColor = kthemeBlackColor;
                cell.arrow.hidden = NO;
                cell.textLab.hidden = NO;
                cell.textLab.text = [NSString stringWithFormat:@"       %@%@",AccountUserInfoModel.extract,@"%"];
                cell.textLab.textColor = kthemeBlackColor;

                break;
            case 1:
                cell.title.text = @"运营分层设置";
                cell.title.textColor = kthemeBlackColor;
                cell.arrow.hidden = NO;
                cell.textLab.hidden = NO;
                cell.textLab.text = [NSString stringWithFormat:@"       %@%@",AccountUserInfoModel.operation_extract,@"%"];
                cell.textLab.textColor = kthemeBlackColor;

                break;
            default:
                break;
        }
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
                [self changeBirthday];
                break;
            case 4:
                
                break;
            case 5:
            {
                ChangeTextController * F = [ChangeTextController initVC];
                F.navtitle = @"签名";
                F.type = textViewType_sign;
                F.block = ^(NSString *changeText) {
                    AccountUserInfoModel.descriptions = changeText;
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
                [self initPicker];
                break;
            case 1:
                [self initPicker];
                break;
            default:
                break;
        }
        
    }
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
                    AccountUserInfoModel.nickname = self.nameTextField.text;
                }else{
                    AccountUserInfoModel.nickname = self.nameTextField.text;

                }
            }
        }
        else
        {
            if ([toBeString getStringLenthOfBytes] > 24)
            {
                self.nameTextField.text = [toBeString subBytesOfstringToIndex:24];
                AccountUserInfoModel.nickname = self.nameTextField.text;

            }else{
                AccountUserInfoModel.nickname = self.nameTextField.text;

            }
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
                    AccountUserInfoModel.popularNo = self.IDTextField.text;

                }else{
                    AccountUserInfoModel.popularNo = self.IDTextField.text;

                }
            }
        }
        else
        {
            if ([toBeString getStringLenthOfBytes] > 24)
            {
                self.IDTextField.text = [toBeString subBytesOfstringToIndex:24];
                AccountUserInfoModel.popularNo = self.IDTextField.text;

            }else{
                AccountUserInfoModel.popularNo = self.IDTextField.text;

            }
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
                    AccountUserInfoModel.gender = @"1";
                    break;
                case 1:
                    AccountUserInfoModel.gender = @"2";
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
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return percentArr.count;
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
    titleStr = [NSString stringWithFormat:@"%@%@",[percentArr objectAtIndex:row],@"%"];
    genderLabel.text = titleStr;
    return genderLabel;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    AccountUserInfoModel.extract= [percentArr objectAtIndex:row];
    NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path,nil] withRowAnimation:NO];
}

#pragma mark - actions
- (void)clickRightButton:(UIButton *)sender;
{
    __weak typeof(self) weakSelf = self;
    _updataUserInfoAction = [SLUpdataUserInfoAction action];
    _updataUserInfoAction.nickname = AccountUserInfoModel.nickname;
    _updataUserInfoAction.popularNo = AccountUserInfoModel.popularNo;
    _updataUserInfoAction.gender = AccountUserInfoModel.gender;
    _updataUserInfoAction.birthday = AccountUserInfoModel.birthday;
    _updataUserInfoAction.city = AccountUserInfoModel.city;
    _updataUserInfoAction.desc = AccountUserInfoModel.descriptions;
//    _updataUserInfoAction.extract = AccountUserInfoModel.extract;
//    _updataUserInfoAction.operation_extract = AccountUserInfoModel.operation_extract;

    _updataUserInfoAction.finishedBlock = ^(id result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSLog(@"  response %@" ,result);
//            AccountUserInfoModel.gender = weakSelf.manBtn.selected?@"1":@"2";
//            [[NSNotificationCenter defaultCenter]postNotificationName:kUserInfoChange object:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    _updataUserInfoAction.failedBlock = ^(NSError *error) {
        
    };
    [_updataUserInfoAction start];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---------scrollView-----------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
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
