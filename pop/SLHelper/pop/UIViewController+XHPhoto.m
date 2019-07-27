//
//  UIViewController+XHPhoto.m

//  XHPhotoExample
//
//  Created by showgx on 17/2/1.
//  Copyright © 2017年 showgx. All rights reserved.

#import "UIViewController+XHPhoto.h"
#import "objc/runtime.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "DeviceInfo.h"
#import <Photos/Photos.h>
#ifdef DEBUG
#define debugLog(...)    NSLog(__VA_ARGS__)
#else
#define debugLog(...)
#endif

static  BOOL canEdit = YES;
static  char blockKey;
@interface UIViewController()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,copy)photoBlock photoBlock;

@end

@implementation UIViewController (XHPhoto)

#pragma mark-set
-(void)setPhotoBlock:(photoBlock)photoBlock
{
    objc_setAssociatedObject(self, &blockKey, photoBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark-get
- (photoBlock )photoBlock
{
    return objc_getAssociatedObject(self, &blockKey);
}
-(void)showCanEdit:(BOOL)edit photo:(photoBlock)block
{
    canEdit = edit;
    
    self.photoBlock = [block copy];
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:DLLocalizedString(@"cancel", nil) destructiveButtonTitle:nil otherButtonTitles:DLLocalizedString(@"Camera", nil), DLLocalizedString(@"PhotoGallery", nil), nil];
    sheet.tag = 2599;
    [sheet showInView:self.view];
    
}

-(void)takephtoEdit:(BOOL)edit photo:(photoBlock)block
{
    canEdit = edit;
    self.photoBlock = [block copy];
    [self openPhotoWithTag:0];
    
}


-(void)cameraChooseEdit:(BOOL)edit photo:(photoBlock)block
{
    canEdit = edit;
    self.photoBlock = [block copy];
    [self openPhotoWithTag:1];
}

-(void)openPhotoWithTag:(NSInteger)tag
{
    
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = canEdit;
    switch (tag)
    {
        case 0:
        {
            //拍照
            //是否支持相机
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                    {
                        
#warning Ant fix bug #10316
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                            [self presentViewController:imagePickerController animated:YES completion:NULL];
                        });
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:DLLocalizedString(@"Alert", nil) message:DLLocalizedString(@"1.0_161", nil) delegate:nil cancelButtonTitle:DLLocalizedString(@"enter", nil) otherButtonTitles:nil, nil];
                            [alert show];
                            
                        });
                    }
                } else{
                    
#warning Ant fix bug #10316
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:DLLocalizedString(@"Device_Error_003", nil) delegate:self cancelButtonTitle:DLLocalizedString(@"1.0_055", nil) otherButtonTitles:DLLocalizedString(@"1.0_054", nil), nil];
                        [alert show];
                    });
                }
            }];
        }
            break;
        case 1:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                //相册
#warning Ant fix bug #10316
                if (status == PHAuthorizationStatusAuthorized) {
                    
                    // ant  回主线程
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        imagePickerController.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
                        [self presentViewController:imagePickerController animated:YES completion:NULL];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:DLLocalizedString(@"Device_Error_003", nil) delegate:self cancelButtonTitle:DLLocalizedString(@"1.0_055", nil) otherButtonTitles:DLLocalizedString(@"1.0_054", nil), nil];
                        
                        [alert show];
                    });
                }
            }];
        }
        default:
            break;
    }
    
}

#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==2599)
    {
        
        switch (buttonIndex)
        {
            case 0:
            {
                [self openPhotoWithTag:0];
                
            }
                break;
            case 1:
            {
                
                [self openPhotoWithTag:1];
                
            }
            default:
                break;
        }
    }
}


#pragma mark - alertDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex==1) {
        [DeviceInfo openAPPSetting];
    }
    
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = nil;
    
    //是否要裁剪
    if ([picker allowsEditing]) {
        //编辑之后的图像
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if(self.photoBlock) {
        self.photoBlock(image);
    }
}




@end
