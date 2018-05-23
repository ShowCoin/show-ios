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

- (void)openAlbum
{
//    [self.photoSelect startPhotoSelect:YHEPhotoSelectFromLibrary];
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.navigationBar.backgroundColor = kthemeBlackColor;
    imagePicker.navigationBar.barTintColor = kthemeBlackColor;
    imagePicker.navigationBar.translucent=YES;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:^{
    }];

//    SLImagePickerControllerV *imagePickController = [[SLImagePickerControllerV alloc] initWithMaxImagesCount:1 delegate:self];
//    [self presentViewController:imagePickController animated:YES completion:nil];
}
#pragma mark - Delegates

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    UIImage *image =photos.firstObject;
    
        NSData * imageData = UIImageJPEGRepresentation(image, 1);
        if (image.size.width >1080&&imageData.length/1000>200) {
            self.uploadImage = image;
            [self supportRetryUploadAvatar];
        }
        else
        {
            [ShowWaringView waringView:@"头像尺寸不符合规则,请重新选择" style:WaringStyleRed];
            self.uploadImage = [UIImage imageNamed:@"userhome_avatar_image"];
        }

}
- (void)notificationHandler: (NSNotification *)notification {
    self.uploadSmallImage = notification.object[0];
    self.uploadImage = notification.object[1];

    [self supportRetryUploadAvatar];
    [self.headerBtn setImage:self.uploadImage];

}

- (void)dissmissPickerAction:(NSNotification *)notification{
    [self.Imgpicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [UIImage fixOrientation:[info objectForKey:UIImagePickerControllerOriginalImage]];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if (picker.cameraDevice == 1) {
            image = [self normalImageWithoriginalImage:image];
        }
    }
    
    NSData * imageData = UIImageJPEGRepresentation(image, 1);
    if (image.size.width >=1080&&image.size.height >=1080&&imageData.length/1000>200) {
        self.uploadImage = image;
        SLCropImageViewController *cropImg = [[SLCropImageViewController alloc] initWithCropImage:image];
        cropImg.isShoot = (picker.sourceType == UIImagePickerControllerSourceTypeCamera);
        self.Imgpicker = picker;
        [self.Imgpicker presentViewController:cropImg animated:YES completion:^{
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissmissPickerAction:) name:@"DISSMISSPICKER" object:nil];
        }];
    }
    else
    {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"头像尺寸不符合规则,请重新选择" message:@"选择头像标准为1080P,比例为16:10,且不小于200k" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertview show];
        //        [ShowWaringView waringView:@"头像尺寸不符合规则,请重新选择" style:WaringStyleRed];
    }

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)alertViewCancel:(UIAlertView *)alertView
{
    [self.Imgpicker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage *)normalImageWithoriginalImage:(UIImage *)originalImage {
    UIImageOrientation imgOrientation; //拍摄后获取的的图像方向
    
    
        
        // 前置摄像头图像方向 UIImageOrientationLeftMirrored
        // IOS前置摄像头左右成像
        imgOrientation = UIImageOrientationLeftMirrored;
        
        NSLog(@"前置摄像头");
    
    return [[UIImage alloc]initWithCGImage:originalImage.CGImage scale:1.0f orientation:imgOrientation];
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
