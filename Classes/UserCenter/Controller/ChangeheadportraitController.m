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
- (void)authorityToJudge{
    @weakify(self);
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized){//用户之前已经授权
        [self openAlbum];
    }else if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied){//用户之前已经拒绝授权
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您之前拒绝了访问照片，请到手机设置" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        [[alert rac_buttonClickedSignal] subscribeNext:^(id x) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                if(@available(iOS 10.0, *)){
                    [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL success) {
                    }];
                }else{
                    [[UIApplication sharedApplication]openURL:url];
                }
            }
        }];
    }else{//弹窗授权时监听
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            @strongify(self);
            if (status == PHAuthorizationStatusAuthorized){//允许
                @weakify(self);
                dispatch_main_async_safe(^{
                    @strongify(self);
                    [self openAlbum];
                }
              );
            }
        }];
    }
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
            SLTakingViewController * tak=[SLTakingViewController initVC];
            tak.isHead = YES;
            [self.navigationController pushViewController:tak animated:YES];

//            UIImagePickerController *imgpicker = [[UIImagePickerController alloc]init];
//            imgpicker.sourceType=UIImagePickerControllerSourceTypeCamera;
//            imgpicker.delegate = self;
//            imgpicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
//            imgpicker.navigationBar.backgroundColor = kthemeBlackColor;
//            imgpicker.navigationBar.barTintColor = kthemeBlackColor;
//            imgpicker.navigationBar.translucent=YES;
//
//            [self presentViewController:imgpicker animated:YES completion:nil];
        }
    }
}

- (void)openAlbum
{
//    [self.photoSelect startPhotoSelect:YHEPhotoSelectFromLibrary];
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.navigationBar.backgroundColor = kBlackWith17;
    imagePicker.navigationBar.barTintColor = kBlackWith17;
    imagePicker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]}; // Title color
    imagePicker.navigationBar.translucent=YES;
    imagePicker.delegate = self;
    if ([imagePicker.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [imagePicker.navigationBar setTranslucent:YES];
        [imagePicker.navigationBar setTintColor:kTextWithF7];
    }
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
        if (image.size.width >720&&imageData.length/1000>100) {
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
    NSData * imageData = UIImageJPEGRepresentation(self.uploadSmallImage, 1);
    NSString * format = [SLHelper contentTypeForImageData:imageData];
    if (format) {
        [self supportRetryUploadAvatar];
        [self.headerBtn setImage:self.uploadSmallImage];
    }
}

- (void)dissmissPickerAction:(NSNotification *)notification{
    [self.Imgpicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [UIImage fixOrientation:[info objectForKey:UIImagePickerControllerOriginalImage]];
    
    NSData * imageData = UIImageJPEGRepresentation(image, 1);
    if (image.size.width >=720&&image.size.height >=1280&&imageData.length/1000>100) {
        self.uploadImage = image;
        SLCropImageViewController *cropImg = [[SLCropImageViewController alloc] initWithCropImage:image withShoot:NO];
        self.Imgpicker = picker;
        [self.Imgpicker presentViewController:cropImg animated:YES completion:^{
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissmissPickerAction:) name:@"DISSMISSPICKER" object:nil];
        }];
    }
    else
    {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"" message:@"欢迎上传高清的头像作为直播的封面，高清的头像才能开播哦。" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertview show];
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
