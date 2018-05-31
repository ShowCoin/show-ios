//
//  SLLMModel.h
//  test
//
//  Created by chenyh on 2018/5/31.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <Foundation/Foundation.h>


// all selector type
typedef NS_ENUM(NSUInteger, SLLMType) {
    SLLMTypeMessage = 0,
    SLLMTypeFront,
    SLLMTypeMirror,
    SLLMTypeMute,
    SLLMTypeShoot,
    SLLMTypeBack,
    SLLMTypeLight
    
};

@interface SLLMModel : NSObject


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *selectTitle;
@property (nonatomic, copy) NSString *selectImage;
@property (nonatomic, assign) BOOL select;
@property (nonatomic, assign) SLLMType type;

// create model
+ (instancetype)initWithTitle:(NSString *)t image:(NSString *)i;
+ (instancetype)sl_create:(SLLMType)type;


@end
