//
//  DCCodeInputView.m
//  ShowLive
//
//  Created by chenyh on 2019/1/26.
//  Copyright © 2019 vning. All rights reserved.
//

#import "DCCodeInputView.h"

/// DCCodeInputView
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

/// setText
/// @param text <#text description#>
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

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewW = 0;
    CGFloat viewH = 0;
    
    self.textLabel.frame = self.bounds;
    
    viewX = 0;
    viewH = 1;
    viewY = h - 1;
    viewW = w;
    self.line.frame = CGRectMake(viewX, viewY, viewW, viewH);
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont sl_fontMediumOfSize:24];
        _textLabel.textColor = kTextWithb6;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = kTextWithb6;
    }
    return _line;
}

+ (NSString *)cellID {
    return NSStringFromClass(self.class);
}

@end

@implementation DCCodeFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    
    CGFloat w = CGRectGetWidth(self.collectionView.frame);
    CGFloat h = CGRectGetHeight(self.collectionView.frame);
    CGFloat itemW = ((w - self.sectionInset.left - self.sectionInset.right) - 10 * 5) / 6;
    CGFloat itemH = h;
    self.itemSize = CGSizeMake(itemW, itemH);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end

