//
//  Day.h
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Day : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+(Day*) dayFromDictionary:(NSDictionary*)dictionary inContext:(NSManagedObjectContext*)context;
-(NSString*) minMaxTemperature;


@end

NS_ASSUME_NONNULL_END

#import "Day+CoreDataProperties.h"
