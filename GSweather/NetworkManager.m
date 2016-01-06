//
//  NetworkManager.m
//  GSweather
//
//  Created by Luke sammut on 6/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import "NetworkManager.h"
#import "FileUtilities.h"
#import "WeatherLocationManager.h"

static NSString *const APIKey = @"f923f5cc51db3ef664ad972733c221bf";
static NSString *const APIUrl = @"https://api.forecast.io/forecast/";

@interface NetworkManager()

@property (strong,nonatomic) NSURLSession *session;

@end

@implementation NetworkManager

+ (instancetype)sharedManager {
    static NetworkManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[NetworkManager alloc] init];
    });
    
    return _sharedManager;
}

-(instancetype) init
{
    self = [super init];
    if(self)
    {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}


-(void) fetchWeatherDataWithLatitude:(double)latitude withLongtitude:(double) longitude withCompletionHandler:(void(^)(NSDictionary* weatherData, NSError *error))completionHandler
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%f,%f",APIUrl,APIKey,latitude,longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithURL:url completionHandler:^(NSURL *  location, NSURLResponse *  response, NSError *  error) {
        
        //insert code here
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSData *weatherData = [NSData dataWithContentsOfURL:location];
            NSDictionary *jSONWeatherData = [NSJSONSerialization JSONObjectWithData:weatherData options:kNilOptions error:nil];
            NSLog(@"%@",jSONWeatherData);
            completionHandler(jSONWeatherData,error);
        });

    }];
    [downloadTask resume];
}

//fetch the weather data based on the users current location
-(void) fetchWeatherDataWithCurrentLocationWithCompletionHandler:(void(^)(NSDictionary* weatherData, NSError *error))completionHandler
{
    CLLocationCoordinate2D coordinate = [[WeatherLocationManager sharedManager] currentLocation].coordinate;
    
    [self fetchWeatherDataWithLatitude:coordinate.latitude withLongtitude:coordinate.longitude withCompletionHandler:^(NSDictionary *weatherData, NSError *error) {
        completionHandler(weatherData, error);
    }];
}

@end
