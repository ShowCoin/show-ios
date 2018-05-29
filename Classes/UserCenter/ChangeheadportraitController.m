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
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    [self.navigationBarView setRightIconImage:[UIImage imageNamed:@"live_bottom_more"] forState:UIControlStateNormal];
    [self.view addSubview:self.headerBtn];
    
    NSString  * imageUrl = AccountUserInfoModel.large_avatar;
    if([imageUrl isKindOfClass:[NSNull class]]){
        imageUrl = nil ;
    }
    @weakify_old(self)
    [_headerBtn yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"userhome_avatar_image"] options:YYWebImageOptionAvoidSetImage completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        @strongify_old(self)
            [strong_self.headerBtn setImage:image];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name: @"CropOK" object: nil];

}
-(void)clickRightButton:(id)sender{
    [self headPortraitClickAuthor];
}
-(UIImageView *)headerBtn
{
    if (!_headerBtn) {
        _headerBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0,  KNaviBarHeight, KScreenWidth, kMainScreenHeight-KNaviBarHeight)];
        _headerBtn.backgroundColor = kthemeBlackColor;
        _headerBtn.contentMode = UIViewContentModeScaleAspectFit;
        _headerBtn.userInteractionEnabled = YES;
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
                                                [self openAlbum];
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
-(void) supportRetryUploadAvatar{
//    [HDHud showHUDInView:self.view title:@"上传中..."];
    @weakify(self);
    NSString *imagePath = [SLPathUtils tempSaveImage:self.uploadSmallImage];
    [[SLBusinessManager manager] uploadPhotoToUserInfo:imagePath upNumber:0 progress:nil finish:^(id result, NSString *imagePath, NSString *videoPath) {
        @strongify(self);
        if ([result isKindOfClass:[NSDictionary class]]) {
            if (IsValidString([result valueForKey:@"avatar"]))
            {
                AccountUserInfoModel.avatar =[result valueForKey:@"avatar"];
                [AccountUserInfoModel save];
            }
        }
        [self supportRetryUploadBigAvatar];
    } failed:^(NSError *error) {
//        @strongify(self);
//        [HDHud hideHUDInView:self.view];
    }];
}
-(void)supportRetryUploadBigAvatar{
    @weakify(self);
    NSString *imagePath = [SLPathUtils tempSaveImage:self.uploadImage];
    [[SLBusinessManager manager] uploadPhotoToUserInfo:imagePath upNumber:1 progress:nil finish:^(id result, NSString *imagePath, NSString *videoPath) {
        @strongify(self);
        if ([result isKindOfClass:[NSDictionary class]]) {
            if (IsValidString([result valueForKey:@"large_avatar"]))
            {
                AccountUserInfoModel.large_avatar =[result valueForKey:@"large_avatar"];
                [AccountUserInfoModel save];
            }
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:kUserInfoChange object:nil];
//        [HDHud hideHUDInView:self.view];
        [self.headerBtn setImage:self.uploadImage];
    } failed:^(NSError *error) {
//        [HDHud hideHUDInView:self.view];
    }];
}
- (void)openCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            UIAlertController *alertController =  [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设备的设置-隐私-相机中允许访问相机! 若不允许，您将无法在SHOW中拍摄视频和照片" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:settingAction];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:^{}];
            
        }else{
            UIImagePickerController *imgpicker = [[UIImagePickerController alloc]init];
            imgpicker.sourceType=UIImagePickerControllerSourceTypeCamera;
            imgpicker.delegate = self;
            imgpicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
            imgpicker.navigationBar.backgroundColor = kthemeBlackColor;
            imgpicker.navigationBar.barTintColor = kthemeBlackColor;
            imgpicker.navigationBar.translucent=YES;
            
            [self presentViewController:imgpicker animated:YES completion:nil];
        }
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
