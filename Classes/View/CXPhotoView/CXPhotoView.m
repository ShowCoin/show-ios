//
//  CXPhotoView.m
//  test
//
//  Created by chenyh on 2018/5/31.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "CXPhotoView.h"
#import <TZImagePickerController.h>

static NSInteger const kRow = 3;
static NSString * const kCXPhotoCellID = @"kCXPhotoCellID";

@interface CXPhotoFlowLayout :  UICollectionViewFlowLayout

@end

@interface CXPhotoCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, copy) void(^cellBlock)(void);

@end

@interface CXPhotoView () <UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *arrays;

@end

@implementation CXPhotoView

+ (instancetype)cx_photoView {
    CXPhotoFlowLayout *layout = [[CXPhotoFlowLayout alloc] init];
    CXPhotoView *view = [[self alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    view.delegate = view;
    view.dataSource = view;
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    view.backgroundColor = [UIColor clearColor];
    view.arrays = [NSMutableArray arrayWithCapacity:9];
    [view registerClass:[CXPhotoCell class] forCellWithReuseIdentifier:kCXPhotoCellID];
    return view;
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrays.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CXPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCXPhotoCellID forIndexPath:indexPath];
    cell.imageView.image = self.arrays[indexPath.item];
    __weak typeof(self) wself = self;
    cell.cellBlock = ^{
        [wself.arrays removeObjectAtIndex:indexPath.item];
        [collectionView reloadData];
    };
    return cell;
}

#pragma mark - Public

- (UIViewController *)getPickerVC {
    TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    picker.allowPickingVideo = NO;
    picker.showSelectedIndex = YES;
    picker.allowPickingOriginalPhoto = YES;
    picker.maxImagesCount = 9 - self.arrays.count;
    return picker;
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    for (PHAsset *as in assets) {
        [TZImageManager.manager getOriginalPhotoWithAsset:as completion:^(UIImage *photo, NSDictionary *info) {
            NSLog(@"queue - %@, photo - %@, info - %@", NSThread.currentThread, photo, info);
            [self.arrays addObject:photo];
            [self reloadData];
        }];
    }
}

@end


@implementation CXPhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor purpleColor];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        self.button = button;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    self.imageView.frame = self.bounds;
    self.button.frame = CGRectMake(w - 44, 0, 44, 44);
}

- (void)buttonAction {
    if (self.cellBlock) {
        self.cellBlock();
    }
}

@end

@implementation CXPhotoFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.sectionInset = UIEdgeInsetsZero;
    
    CGFloat w = self.collectionView.frame.size.width;
    CGFloat itemWH = (w - self.minimumInteritemSpacing * (kRow - 1)) / kRow;
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
}

@end
