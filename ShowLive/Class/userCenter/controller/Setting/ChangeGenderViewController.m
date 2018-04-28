//
//  ChangeGenderViewController.m
//  ShowLive
//
//  Created by VNing on 2018/4/6.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ChangeGenderViewController.h"

@interface ChangeGenderViewController ()
@property(strong,nonatomic)UIButton * manBtn;
@property(strong,nonatomic)UIButton * womenBtn;

@end

@implementation ChangeGenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationTitle:STRING_USER_EDIT_GENDER_67];
    [self.navigationBarView setNavigationColor:NavigationColorwihte];
    [self setViews];
}

-(void)setViews{
    [self.view addSubview:self.manBtn];
    [self.view addSubview:self.womenBtn];
}
-(UIButton *)manBtn
{
    if (!_manBtn) {
        _manBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 120*Proportion375 + kNaviBarHeight, 110*Proportion375, 110*Proportion375)];
        _manBtn.centerX = kMainScreenWidth/2;
        _manBtn.layer.masksToBounds =YES;
        
        [_manBtn setBackgroundImage:[UIImage imageNamed:@"userhome_user_man_no"] forState:UIControlStateNormal];
        [_manBtn setBackgroundImage:[UIImage imageNamed:@"userhome_user_man_yes"] forState:UIControlStateSelected];
        [_manBtn addTarget:self action:@selector(manAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _manBtn;
}
-(UIButton *)womenBtn
{
    if (!_womenBtn) {
        _womenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 110*Proportion375 + _manBtn.bottom, 110*Proportion375, 110*Proportion375)];
        _womenBtn.centerX = kMainScreenWidth/2;
        [_womenBtn setBackgroundImage:[UIImage imageNamed:@"userhome_user_woman_no"] forState:UIControlStateNormal];
        [_womenBtn setBackgroundImage:[UIImage imageNamed:@"userhome_user_woman_yes"] forState:UIControlStateSelected];
        
        [_womenBtn addTarget:self action:@selector(womanAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _womenBtn;
}
-(void)manAction:(UIButton *)sender
{
    _manBtn.selected = !_manBtn.selected;
}
-(void)womanAction:(UIButton *)sender
{
    _womenBtn.selected = !_womenBtn.selected;
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
