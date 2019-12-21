//
//  SLCountryCover.m
//  ShowLive
//
//  Created by chenyh on 2019/11/28.
//  Copyright © 2019 vning. All rights reserved.
//

#import "SLCountryCover.h"
#import "SLCountryCell.h"

@interface SLCountryCover () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SLCountryCover

/// initWithFrame
/// @param frame <#frame description#>
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.7];
        self.alpha = 0;
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews {
    self.tableView.frame = self.bounds;
}

- (void)setAlpha:(CGFloat)alpha {
    [super setAlpha:alpha];
    if (alpha == 0) {
        self.tableView.alpha = 0;
    }
}

- (void)setHideTable:(BOOL)hideTable {
    self.tableView.alpha = hideTable ? 0 : 1;
}

- (void)setRows:(NSArray *)rows {
    _rows = rows;
    self.tableView.alpha = 1;
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:SLCountryCell.cellID];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(SLCountryCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = self.rows[indexPath.row];
}

#pragma mark - lazy

/// tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = OTCBackgroundColor();
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.rowHeight = 44.0;
        
        [_tableView registerClass:SLCountryCell.class forCellReuseIdentifier:SLCountryCell.cellID];
    }
    return _tableView;
}

@end
