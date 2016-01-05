//
//  Day+CoreDataProperties.h
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Day.h"

NS_ASSUME_NONNULL_BEGIN

@interface Day (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *precipProbabilty;
@property (nullable, nonatomic, retain) NSString *summary;
@property (nullable, nonatomic, retain) NSDate *sunrise;
@property (nullable, nonatomic, retain) NSDate *sunset;
@property (nullable, nonatomic, retain) NSNumber *tempMax;
@property (nullable, nonatomic, retain) NSNumber *tempMin;
@property (nullable, nonatomic, retain) NSString *icon;

@end

NS_ASSUME_NONNULL_END
