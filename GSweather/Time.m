//
//  Time.m
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import "Time.h"


@implementation Time

// Insert code here to add functionality to your managed object subclass


+(Time*) currentTimeFromDictionary:(NSDictionary*)dictionary inContext:(NSManagedObjectContext*)context
{
    Time *currentTime = [Time MR_createEntityInContext:context];
    currentTime.time = [NSDate dateWithTimeIntervalSince1970:  [dictionary[@"currently"][@"time"] doubleValue]];
    currentTime.summary = dictionary[@"currently"][@"summary"];
    currentTime.icon = dictionary[@"currently"][@"icon"];
    currentTime.precipProbablility  = dictionary[@"currently"][@"precipProbabilty"];
    currentTime.temperature = dictionary[@"currently"][@"temperature"];

    return currentTime;
}


//class method for the hourly times time
+(Time*) hourlyTimeFromDictionary:(NSDictionary*) dictionary inContext:(NSManagedObjectContext*)context
{
    
    Time *time = [Time MR_createEntityInContext:context];
    time.time = [NSDate dateWithTimeIntervalSince1970: [dictionary[@"time"] doubleValue]];
    time.summary = dictionary[@"summary"];
    time.icon = dictionary[@"icon"];
    time.precipProbablility = dictionary[@"precipProbabilty"];
    time.temperature = dictionary[@"temperature"];
    
    return time;
}

@end
