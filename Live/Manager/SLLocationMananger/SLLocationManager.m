//
//  SLLocationManager.m
//  ShowLive
//
//  Created by gongxin on 2018/4/23.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLocationManager.h"
#import <MapKit/MapKit.h>

static SLLocationManager * manager = nil;

@interface SLLocationManager ()<CLLocationManagerDelegate,UIAlertViewDelegate>
{
    CLLocationManager  * locationManager;
    NSDictionary * locationInfo;
    NSString * latitude;
    NSString * longitude;
    
    double latitude_f;
    double longitude_f;
}
@end
@implementation SLLocationManager


+(SLLocationManager*)shareManager;
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[SLLocationManager alloc] init];

    });
    return manager;
}

-(void)stopLocation
{
    
    [locationManager stopUpdatingLocation];
}

- (BOOL)userAuthorized
{
    BOOL enable = [CLLocationManager locationServicesEnabled];

    
    return enable;
}

-(void)startLocationWithAlert:(BOOL)sender
{
    //定位服务是否可用
    BOOL enable=[CLLocationManager locationServicesEnabled];
    if (enable) {
        
        // 精准度越高，电量消耗越大。我们要选择能够满足最低要求的精准度级别
        locationManager=[[CLLocationManager alloc]init];
        locationManager.desiredAccuracy=kCLLocationAccuracyKilometer;
        locationManager.distanceFilter=100.f;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            //请求权限,ios8以后需手动开启授权
            [locationManager requestWhenInUseAuthorization];
            
        }
        
        //定位权限状态
        int authorizationstatus=[CLLocationManager authorizationStatus];
        //用户未作选择
        if (authorizationstatus==kCLAuthorizationStatusNotDetermined) {
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            {
                //请求权限,ios8以后需手动开启授权
                [locationManager requestWhenInUseAuthorization];
                
            }
            
        }else if (authorizationstatus==kCLAuthorizationStatusDenied)
        {
            
            [self locationManagerError];
            
        }
        
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
        
    }else
    {
        if (sender) {
            [self locationManagerError];
        }
    }
}

-(void)startLocation
{
    [self startLocationWithAlert:YES];
}

#pragma mark locationManagerdelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    CLLocation * currrLocation = [locations lastObject];
    
    latitude  = [NSString stringWithFormat:@"%f",currrLocation.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f",currrLocation.coordinate.longitude];
    
    latitude_f = currrLocation.coordinate.latitude;
    longitude_f = currrLocation.coordinate.longitude;
    [AccountModel shared].cityLng =Float12String(longitude_f) ;
    [AccountModel shared].cityLng =Float12String(latitude_f) ;
    [[AccountModel shared] save];

    CLGeocoder * geocoder = [[CLGeocoder alloc]init];
    @weakify(self)
    [geocoder reverseGeocodeLocation:currrLocation completionHandler:^(NSArray * placemarkrs,NSError * error){
        @strongify(self)
        if ([placemarkrs count]>0)
        {
            CLPlacemark * placemark = placemarkrs[0];
            self->locationInfo = placemark.addressDictionary;
       //     NSString *countryCode = [locationInfo valueForKey:@"CountryCode"];
            NSString *city        = [self->locationInfo valueForKey:@"City"];
//            NSString *country     = [locationInfo valueForKey:@"Country"];
//            NSString *provience   = [locationInfo valueForKey:@"State"];
//
            [AccountModel shared].city = city;
            [[AccountModel shared] save];
          
        }
        
    }];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位出错++%@",error.description);
}

-(void)locationManagerError
{
    //无法定位，因为您的设备没有开启定位服务，请到设置中启用
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"因为您的设备没有开启定位服务，请到设置中启用" delegate:self cancelButtonTitle:@"取消"  otherButtonTitles:@"设置", nil];
        [alert show];
        
    });
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1) {
        
        UIApplication *app = [UIApplication sharedApplication];
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([app canOpenURL:settingsURL]) {
            [app openURL:settingsURL];
        }
    }
}
-(NSDictionary*)getLocationInfo;
{
    return locationInfo;
}
-(NSString*)getLatitude;

{
    return latitude;
    
}
-(NSString*)getLongitude;
{
    return longitude;
}

- (double)getLatitude_f {
    return latitude_f;
}

- (double)getLongitude_f {
    return longitude_f;
}

@end
