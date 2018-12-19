 //
//  ChangeheadportraitController.m
//  ShowLive
//
//  Created by vning on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ChangeheadportraitController.h"
#import "SLCropImageViewController.h"
#import "UIImage+Effects.h"
#import "SLTakingViewController.h"
@interface ChangeheadportraitController ()
{
    NSInteger uploadNum;
    NSInteger uploadAllNum;

}
@property(nonatomic,strong)UIImageView * headerBtn;
@property(nonatomic,strong)UIImage * uploadImage;
@property(nonatomic,strong)UIImage * uploadSmallImage;
@property (nonatomic,strong)UIImagePickerController *Imgpicker;


@end

@implementation ChangeheadportraitController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationTitle:STRING_USER_EDIT_HEADPORTRAIT_64];
    [self.navigationBarView setNavigationColor:NavigationColor1717];
    [self.navigationBarView setRightIconImage:[UIImage imageNamed:@"live_bottom_more"] forState:UIControlStateNormal];
    [self.view addSubview:self.headerBtn];
    
    NSString  * imageUrl = AccountUserInfoModel.middle_avatar;
    if([imageUrl isKindOfClass:[NSNull class]]){
        imageUrl = nil ;
    }
    @weakify_old(self)
    [_headerBtn yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"home_start_img"] options:YYWebImageOptionAvoidSetImage completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        @strongify_old(self)
            [strong_self.headerBtn setImage:image];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name: @"CropOK" object: nil];
 
    [PageManager manager].changeHead = YES;
}

-(void)dealloc
{
    [PageManager manager].changeHead = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [SLReportManager reportPageBegin:kReport_UploadPhotoPage];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [SLReportManager reportPageEnd:kReport_UploadPhotoPage];
}

-(void)clickRightButton:(id)sender{
    [self headPortraitClickAuthor];
}
-(UIImageView *)headerBtn
{
    if (!_headerBtn) {
        _headerBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0,  KNaviBarHeight, KScreenWidth, kMainScreenHeight-KNaviBarHeight)];
        _headerBtn.backgroundColor = kBlackWith1c;
        _headerBtn.contentMode = UIViewContentModeScaleAspectFit;
        _headerBtn.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer    alloc]init];
        [_headerBtn addGestureRecognizer:tap];
        @weakify(self);
        [[tap rac_gestureSignal]subscribeNext:^(id x) {
            @strongify(self);
            [self headPortraitClickAuthor];
        }];
    }
    return _headerBtn;
}


- (void)headPortraitClickAuthor{
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
                                                [self openCamera];
                                            }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                
                                                [self authorityToJudge];
                                            }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:STRING_IDENTIFY_CHECKCANCLE_10
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction *action) {
                                                NSLog(@"Action 3 Handler Called");
                                            }]];
    
    UIPopoverPresentationController *popover = alert.popoverPresentationController;
   
    //ipad 下需加入这段代码，否则崩溃
    if (popover) {
        popover.sourceView = self.view;
        popover.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0);
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void) supportRetryUploadAllAvatar{
    NSString *imagePath = [SLPathUtils tempSaveImage:self.uploadSmallImage];

    [[SLBusinessManager manager] uploadPhotosToUserInfo:@[imagePath]  progress:nil finish:^(id result, NSString *imagePath, NSString *videoPath) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            if (IsValidString([result valueForKey:@"avatar"]))
            {
                AccountUserInfoModel.avatar =[result valueForKey:@"avatar"];
            }
            [AccountUserInfoModel save];
        }
    } failed:^(NSError *error) {

    }];

}
-(void) supportRetryUploadAvatar{
    [HDHud showHUDInView:self.view title:@"上传中..."];
    @weakify(self);
    NSString *imagePath = [SLPathUtils tempSaveImage:self.uploadSmallImage];
    [[SLBusinessManager manager] uploadPhotoToUserInfo:imagePath upNumber:0 progress:nil finish:^(id result, NSString *imagePath, NSString *videoPath) {
        @strongify(self);
        [HDHud hideHUDInView:self.view];
        if ([result isKindOfClass:[NSDictionary class]]) {
            if (IsValidString([result valueForKey:@"avatar"]))
            {
                AccountUserInfoModel.avatar =[result valueForKey:@"avatar"];
                AccountUserInfoModel.is_change_avatar =@"1";
                [AccountUserInfoModel save];
            }
        }
        [self.navigationController popViewControllerAnimated:YES];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:SLPREVIEWAVATARCHANGE object:nil];
        
        
//        [self supportRetryUploadBigAvatar];
    } failed:^(NSError *error) {
        @strongify(self);
        [HDHud hideHUDInView:self.view];
    }];
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
