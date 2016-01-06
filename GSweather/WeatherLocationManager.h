//
//  WeatherLocationManager.h
//  GSweather
//
//  Created by Luke sammut on 6/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WeatherLocationManager : NSObject


-(CLLocation*) currentLocation;
+ (instancetype)sharedManager;

@end
