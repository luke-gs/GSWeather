//
//  Weather.m
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import "Weather.h"
#import "Day.h"
#import "Time.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation Weather

// Insert code here to add functionality to your managed object subclass

+ (Weather *)weatherFromDictionary:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context
{
    
    Weather *weather = [Weather MR_createEntityInContext:context];
    weather.latitude = [dictionary valueForKey:@"latitude"];
    weather.longitude = [dictionary valueForKey:@"longitude"];
    weather.timeZone = dictionary[@"timezone"];
    
    //set the current time
    Time* currentTime = [Time currentTimeFromDictionary:dictionary inContext:context];
    weather.currentTime = currentTime;
    
    for (NSDictionary *hourlyDictionary in dictionary[@"hourly"][@"data"]) {
        Time *hourlyTime = [Time hourlyTimeFromDictionary:hourlyDictionary inContext:context];
        if(hourlyDictionary)
        {
            [weather addHourlyWeatherObject:hourlyTime];
        }
    }
    
    for(NSDictionary *dailyDictionary in dictionary[@"daily"][@"data"])
    {
        Day *dailyWeather = [Day dayFromDictionary:dailyDictionary inContext:context];
        if(dailyWeather)
        {
            [weather addDailyWeatherObject:dailyWeather];
        }
    }
    
    weather.lastUpdated = [NSDate date];
    return weather;
}

-(NSArray*) sortedDailyWeather {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];

    
    NSArray *sortedDailyWeather = [self.dailyWeather sortedArrayUsingDescriptors:@[sortDescriptor]];
    return sortedDailyWeather;
	
}

@end
