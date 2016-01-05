//
//  Time+CoreDataProperties.h
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Time.h"

NS_ASSUME_NONNULL_BEGIN

@interface Time (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *icon;
@property (nullable, nonatomic, retain) NSNumber *precipProbablility;
@property (nullable, nonatomic, retain) NSString *summary;
@property (nullable, nonatomic, retain) NSNumber *temperature;
@property (nullable, nonatomic, retain) NSDate *time;

@end

NS_ASSUME_NONNULL_END
