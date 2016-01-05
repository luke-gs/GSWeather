//
//  Weather.h
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day, Time;

NS_ASSUME_NONNULL_BEGIN

@interface Weather : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (Weather *)weatherFromDictionary:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context;

-(NSArray*) sortedDailyWeather;
@end

NS_ASSUME_NONNULL_END

#import "Weather+CoreDataProperties.h"
