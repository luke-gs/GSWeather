//
//  Weather+CoreDataProperties.h
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface Weather (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *lastUpdated;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *timeZone;
@property (nullable, nonatomic, retain) Time *currentTime;
@property (nullable, nonatomic, retain) NSSet<Day *> *dailyWeather;
@property (nullable, nonatomic, retain) NSSet<Time *> *hourlyWeather;

@end

@interface Weather (CoreDataGeneratedAccessors)

- (void)addDailyWeatherObject:(Day *)value;
- (void)removeDailyWeatherObject:(Day *)value;
- (void)addDailyWeather:(NSSet<Day *> *)values;
- (void)removeDailyWeather:(NSSet<Day *> *)values;

- (void)addHourlyWeatherObject:(Time *)value;
- (void)removeHourlyWeatherObject:(Time *)value;
- (void)addHourlyWeather:(NSSet<Time *> *)values;
- (void)removeHourlyWeather:(NSSet<Time *> *)values;

@end

NS_ASSUME_NONNULL_END
