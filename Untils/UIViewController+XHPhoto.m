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

@end
