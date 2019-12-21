//
//  DCCodeInputView.m
//  ShowLive
//
//  Created by chenyh on 2019/1/26.
//  Copyright © 2019 vning. All rights reserved.
//

#import "DCCodeInputView.h"

@interface DCCodeFlowLayout : UICollectionViewFlowLayout

@end

@interface DCCodeCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, readonly, class) NSString *cellID;

@end

@interface DCCodeInputView ()

@property (nonatomic, strong) NSArray *items;

@end

