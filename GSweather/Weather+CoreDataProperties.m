//
//  Weather+CoreDataProperties.m
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Weather+CoreDataProperties.h"

@implementation Weather (CoreDataProperties)

@dynamic lastUpdated;
@dynamic latitude;
@dynamic longitude;
@dynamic timeZone;
@dynamic currentTime;
@dynamic dailyWeather;
@dynamic hourlyWeather;

@end
