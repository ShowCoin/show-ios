//
//  SLPrivateChatViewController+Events.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLPrivateChatViewController+Events.h"
#import "SLPrivateChatViewController+Business.h"
#import "SLPrivateChatViewController+TableView.h"
#import "SLPrivateChatViewController+InputView.h"
#import "SLPrivateChatViewController+MessageSend.h"
#import "SLPrivateChatViewController+Common.h"
#import "SLAudioManager.h"
#import <AVFoundation/AVFoundation.h>
@implementation SLPrivateChatViewController (Events)
#pragma mark - Cell Events

- (void)handleVoiceCellContentClickWithCell:(id<SLChatVoiceMessageCellProtocol>)cell viewModel:(id<SLChatVoiceMessageCellViewModel>)viewModel
{
    RCMessage *rcMessage = viewModel.rcMessage;
    RCVoiceMessage *voiceMsg = (RCVoiceMessage *)rcMessage.content;
    NSData *voiceData = voiceMsg.wavAudioData;
    if (![[SLAudioManager sharedManager] playAudioWithData:voiceData]) {
        return;
    }
    
    // update viewModel
    BOOL flag = [self.business setMessageReceivedStatusWithMessageId:viewModel.rcMessage.messageId rcReceivedStatus:ReceivedStatus_LISTENED];
    if(!flag){
        return;
    }
    //TODO:这里需要优化， cell滑动后就不显示动画了？这是产品需求吗？
    rcMessage.receivedStatus = ReceivedStatus_LISTENED;
    viewModel.rcMessage = rcMessage;
    
    [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(__kindof id<SLChatMessageCellProtocol> _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(SLChatVoiceMessageCellProtocol)]) {
            id<SLChatVoiceMessageCellProtocol> cell = obj;
            [cell stopAnimation];
        }
    }];
    [cell startAnimation];
}

#pragma mark - Tap
- (void)handleVideoRecordingAction
{
    UIAlertController *alertController =  [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openAlbum];
    }];
    [alertController addAction:cancel];
    [alertController addAction:cameraAction];
    [alertController addAction:albumAction];
    [self presentViewController:alertController animated:YES completion:^{}];
    
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
            imgpicker.allowsEditing = YES;
            imgpicker.delegate = self;
            imgpicker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
            imgpicker.navigationBar.backgroundColor = kthemeBlackColor;
            imgpicker.navigationBar.barTintColor = kthemeBlackColor;
            imgpicker.navigationBar.translucent=YES;
            
            [self presentViewController:imgpicker animated:YES completion:nil];
        }
    }
}

- (void)openAlbum
{
    SLImagePickerControllerV *imagePickController = [[SLImagePickerControllerV alloc] initWithMaxImagesCount:1 delegate:self];
    [self presentViewController:imagePickController animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    UIImage *image = photos.firstObject;
    [self sendMedioMessageWithMedio:image];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self sendMedioMessageWithMedio:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)handleSendDiceMessageAction
{
    [self addMsgSendTimeAsNow];
}
@end
