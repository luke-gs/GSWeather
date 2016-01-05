//
//  Time.h
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>
#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface Time : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+(Time*) currentTimeFromDictionary:(NSDictionary*)dictionary inContext:(NSManagedObjectContext*)context;
+(Time*) hourlyTimeFromDictionary:(NSDictionary*) dictionary inContext:(NSManagedObjectContext*)context;


@end

NS_ASSUME_NONNULL_END

#import "Time+CoreDataProperties.h"
