//
//  DWTagList.h
//
//  Created by Dominic Wroblewski on 07/07/2012.
//  Copyright (c) 2012 Terracoding LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DWTagList;

@protocol DWTagListDelegate <NSObject>
@optional
-(void)clickWithStr:(NSString*)str;
-(void)clickWithStr:(NSString *)str  index:(NSInteger)index;
@end
@interface DWTagList : UIView
{
    UIView *view;
    NSArray *textArray;
    CGSize sizeFit;
    UIColor *lblBackgroundColor;
}

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic,weak)id<DWTagListDelegate>  delegate;

- (void)setLabelBackgroundColor:(UIColor *)color withType:(NSInteger)type;
- (void)setTags:(NSArray *)array;
- (void)display;
- (CGSize)fittedSize;

@end
