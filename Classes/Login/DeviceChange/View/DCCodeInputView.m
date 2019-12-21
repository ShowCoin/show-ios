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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:DCCodeCell.cellID forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(DCCodeCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = self.items[indexPath.item];
}

- (void)setText:(NSString *)text {
    _text = text;
    NSMutableArray *tmp = [NSMutableArray array];
    for (int i = 0; i < text.length; i ++) {
        NSString *c = [text substringWithRange:NSMakeRange(i, 1)];
        [tmp addObject:c];
    }
    NSUInteger count = kDCGoogleCodeLength - tmp.count;
    while (count--) {
        [tmp addObject:@""];
    }
    self.items = tmp;
    [self reloadData];
}

@end

@implementation DCCodeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.textLabel];
        [self.contentView addSubview:self.line];
    }
    return self;
}
