//
//  WeatherLocationManager.m
//  GSweather
//
//  Created by Luke sammut on 6/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import "WeatherLocationManager.h"


@interface WeatherLocationManager() <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end


@implementation WeatherLocationManager

+ (instancetype)sharedManager {
    static WeatherLocationManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[WeatherLocationManager alloc] init];
    });
    
    return _sharedManager;
}


-(instancetype)init
{
    self = [super init];
    if(self){
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        self.locationManager.distanceFilter = 1000.0;
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

-(CLLocation*) currentLocation
{
    return self.locationManager.location;
}

@end
