//
//  MYQLocationManager.h
//  MianYangQuan
//
//  Created by Zong on 16/2/18.
//  Copyright © 2016年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

typedef void(^GetLocationSuccessBlock)(CLLocation *location);


@interface MYQLocationManager : NSObject

+ (instancetype)shareLocationManager;
- (void)locationWithSuccessBlock:(GetLocationSuccessBlock)getLocationSuccessBlock;

@end
