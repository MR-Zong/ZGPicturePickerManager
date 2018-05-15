//
//  MYQLocationManager.m
//  MianYangQuan
//
//  Created by Zong on 16/2/18.
//  Copyright © 2016年 kk. All rights reserved.
//

#import "MYQLocationManager.h"
#import <CoreLocation/CoreLocation.h>


#define isIOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)

@interface MYQLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationM;

@property (nonatomic, copy) GetLocationSuccessBlock getLocationSuccessBlock;

@end

@implementation MYQLocationManager

+ (instancetype)shareLocationManager
{
    static MYQLocationManager *_locationM_ = nil;
    static dispatch_once_t onceToken = 0;
    
    if (!_locationM_) {
        dispatch_once(&onceToken, ^{
            _locationM_ = [[MYQLocationManager alloc] init];
        });
    }
    
    return _locationM_;
    
}


- (void)locationWithSuccessBlock:(GetLocationSuccessBlock)getLocationSuccessBlock
{
    self.getLocationSuccessBlock = getLocationSuccessBlock;
    [self.locationM startUpdatingLocation];
}


#pragma mark - <CLLocationManagerDelegate>
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    if(location.horizontalAccuracy < 0)
        return;
    
    NSLog(@"定位到了--%@", location);
    if (self.getLocationSuccessBlock) {
        self.getLocationSuccessBlock(location);
    }
    [manager stopUpdatingLocation];
    
}

// status : 当前的授权状态
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户未决定");
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"受限制");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 判断当前设备是否支持定位, 并且定位服务是否开启()
            if([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"定位开启,被拒绝");
                [self showWarnning];
                
            }else
            {
                NSLog(@"定位服务关闭");
                [self showWarnning];
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"前后台定位授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"前台定位授权");
            break;
        }
            
        default:
            break;
    }
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败 error %@",error);
}

#pragma mark - showWarnning
- (void)showWarnning
{
    // ios8,0- 需要截图提醒引导用户
    //    if (!isIOS(8)) {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"定位没开，没有办法获取到附近的人哦" message:@"请在手机系统的[设置]-[隐私]-[定位服务]中打开定位服务，并开启哄你睡的定位服务" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [alertView show];
    //    }
}


#pragma mark - lazyLoad
-(CLLocationManager *)locationM
{
    if (!_locationM) {
        
        _locationM = [[CLLocationManager alloc] init];
        _locationM.delegate = self;
        
        _locationM.desiredAccuracy = kCLLocationAccuracyBest;
        
        if([_locationM respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [_locationM requestAlwaysAuthorization];
        }
        
    }
    return _locationM;
}


@end
