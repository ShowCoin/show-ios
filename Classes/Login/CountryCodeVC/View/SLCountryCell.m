//
//  SLCountryCell.m
//  ShowLive
//
//  Created by chenyh on 2019/11/28.
//  Copyright © 2019 vning. All rights reserved.
//

#import "SLCountryCell.h"

@implementation SLCountryCell

/// initWithStyle
/// @param style cell style
/// @param reuseIdentifier reuseIdentifier
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kWhiteSeparationColor1;
        self.contentView.backgroundColor = UIColor.clearColor;
        self.textLabel.textColor = OTCWhiteColor();
        self.textLabel.font = [UIFont systemFontOfSize:16.0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.showBottomLine = YES;
    }
    return self;
}

@end
