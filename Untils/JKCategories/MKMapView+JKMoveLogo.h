//
//  MKMapView+MoveLogo.h
//
//  Created by Maciej Swic on 2013-07-08.
//  Released under the MIT license.
//
//  This category allows you to move the MKMapView logo so that it remains visible if you
//  put other stuff on the mapview. If the logo is hidden, the app won't pass the App Store
//  review. Tested with iOS 5 through 7.
//

#import <MapKit/MapKit.h>

@interface MKMapView (JKMoveLogo)
//移动logo的位置
- (void)jk_moveLogoByOffset:(CGPoint)offset;
//移动logo位置到置顶地点
- (void)jk_moveLogoToPoint:(CGPoint)point;
//获取logo
- (UIView*)jk_logo;

@end
