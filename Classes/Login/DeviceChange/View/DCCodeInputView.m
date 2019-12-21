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

@implementation DCCodeInputView

+ (instancetype)inputView {
    DCCodeFlowLayout *layout = [[DCCodeFlowLayout alloc] init];
    DCCodeInputView *view = [[DCCodeInputView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    view.delegate = view;
    view.dataSource = view;
    view.scrollEnabled = NO;
    view.bounces = NO;
    view.backgroundColor = [UIColor clearColor];
    view.items = @[@"", @"", @"", @"", @"", @"", ];
    [view registerClass:DCCodeCell.class forCellWithReuseIdentifier:DCCodeCell.cellID];
    return view;
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}
