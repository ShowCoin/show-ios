//
//  SLMoreCollectionViewCell.h
//  ShowLive
//
//  Created by gongxin on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLLMModel;

typedef NS_ENUM(NSUInteger, SLLMType) {
    SLLMTypeMessage = 0,
    SLLMTypeFront,
    SLLMTypeMirror,
    SLLMTypeMute,
    SLLMTypeShoot,
    SLLMTypeBack,
    SLLMTypeLight
    
};

static NSString * const kSLMoreCollectionViewCellID = @"kSLMoreCollectionViewCellID";

@interface SLMoreCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SLLMModel *model;

@end

@interface SLLMModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *selectTitle;
@property (nonatomic, copy) NSString *selectImage;
@property (nonatomic, assign) BOOL select;
@property (nonatomic, assign) SLLMType type;


+ (instancetype)initWithTitle:(NSString *)t image:(NSString *)i;
+ (instancetype)sl_create:(SLLMType)type;

@end
