//
//  SLGiftListModel.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLGiftListModel.h"

@implementation SLGiftListModel


- (void)analysisGiftInfowithModel:(SLGiftListModel *)model
{
    
    self.exp = model.exp;
    self.icon = model.icon;
    self.id = model.id;
    self.image = model.image;
    self.name = model.name;
    self.price = model.price;
    self.type = model.type;
    self.zipUrl = model.zipUrl;
    self.giftUniTag = model.giftUniTag;
    self.doubleHit = model.doubleHit;

}

@end
