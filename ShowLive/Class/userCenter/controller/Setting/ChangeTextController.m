//
//  ChangeTextController.m
//  ShowLive
//
//  Created by vning on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ChangeTextController.h"

@interface ChangeTextController ()<UITextFieldDelegate>
@end

@implementation ChangeTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationTitle:self.navtitle];
    [self.navigationBarView setNavigationColor:NavigationColorwihte];
    [self.navigationBarView setRightTitle:@"保存"];
    [self setViews];

}
-(void)setViews{
    UITextField * field = [[UITextField alloc]initWithFrame:CGRectMake(0,kNaviBarHeight+2, kMainScreenWidth,60*Proportion375)];
    field.backgroundColor = kThemeWhiteColor;
    field.font = Font_Regular(15);
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.textAlignment = NSTextAlignmentLeft;
    field.autocorrectionType = UITextAutocorrectionTypeNo;
    field.keyboardType = UIKeyboardTypeDefault;
    field.returnKeyType = UIReturnKeyDone;
    field.delegate = self;
    field.autocapitalizationType = UITextAutocapitalizationTypeNone;
    field.textColor = kTextGrayColor;
    field.tintColor = kthemeBlackColor;
//    [field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:field];
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
