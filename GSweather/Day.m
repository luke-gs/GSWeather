//
//  Day.m
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import "Day.h"
#import <MagicalRecord/MagicalRecord.h>
#import "WeatherUtilities.h"

@implementation Day

// Insert code here to add functionality to your managed object subclass

+(Day*) dayFromDictionary:(NSDictionary*)dictionary inContext:(NSManagedObjectContext*)context
{
    Day *day = [Day MR_createEntityInContext:context];
    day.date = [NSDate dateWithTimeIntervalSince1970: [dictionary[@"time"]doubleValue]];
    day.summary = dictionary[@"summary"];
    day.icon = dictionary[@"icon"];
    day.sunset = [NSDate dateWithTimeIntervalSince1970: [dictionary[@"sunsetTime"] doubleValue]];
    day.sunrise = [NSDate dateWithTimeIntervalSince1970: [dictionary[@"sunriseTime"] doubleValue]];
    day.tempMin = dictionary[@"temperatureMin"];
    day.tempMax = dictionary[@"temperatureMax"];
    day.precipProbabilty = dictionary[@"precipProbabilty"];
    
    return day;
}


-(NSString*) minMaxTemperature{
    
   return [NSString stringWithFormat:@" %.1f° / %.1f°", [WeatherUtilities farenheitToCelcius:[self.tempMin doubleValue]],[WeatherUtilities farenheitToCelcius: [self.tempMax doubleValue]]];
}

@end
