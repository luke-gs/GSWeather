//
//  NetworkManager.h
//  GSweather
//
//  Created by Luke sammut on 6/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;

-(void) fetchWeatherDataWithLatitude:(double)latitude withLongtitude:(double) longitude withCompletionHandler:(void(^)(NSDictionary* weatherData, NSError *error))completionHandler;

-(void) fetchWeatherDataWithCurrentLocationWithCompletionHandler:(void(^)(NSDictionary* weatherData, NSError *error))completionHandler;
@end
