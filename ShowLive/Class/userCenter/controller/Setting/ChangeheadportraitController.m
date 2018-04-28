//
//  ChangeheadportraitController.m
//  ShowLive
//
//  Created by VNing on 2018/4/6.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ChangeheadportraitController.h"

@interface ChangeheadportraitController ()
@property(nonatomic,strong)UIButton * headerBtn;
@end

@implementation ChangeheadportraitController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationTitle:STRING_USER_EDIT_HEADPORTRAIT_64];
    [self.navigationBarView setNavigationColor:NavigationColorwihte];
    [self.navigationBarView setRightIconImage:[UIImage imageNamed:@"userhome_avatar_more"] forState:UIControlStateNormal];
    [self.view addSubview:self.headerBtn];
}

-(UIButton *)headerBtn
{
    if (!_headerBtn) {
        _headerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 85 + kNaviBarHeight, kMainScreenWidth, kMainScreenWidth)];
        [_headerBtn setBackgroundImage:[UIImage imageNamed:@"userhome_avatar_image"] forState:UIControlStateNormal];
        [_headerBtn setBackgroundImage:[UIImage imageNamed:@"userhome_avatar_image"] forState:UIControlStateHighlighted];
        [_headerBtn addTarget:self action:@selector(showTheimagePicker) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerBtn;
}


- (void)clickRightButton:(UIButton *)sender;
{
    [self showTheimagePicker];
}
-(void)showTheimagePicker
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:STRING_USER_EDIT_PICKER_71
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                NSLog(@"Action 1 Handler Called");
                                            }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:STRING_USER_EDIT_PICKER_71
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                NSLog(@"Action 2 Handler Called");
                                            }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:STRING_IDENTIFY_CHECKCANCLE_10
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction *action) {
                                                NSLog(@"Action 3 Handler Called");
                                            }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    


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
