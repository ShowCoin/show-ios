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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
