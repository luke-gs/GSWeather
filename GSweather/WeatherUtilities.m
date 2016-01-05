//
//  WeatherUtilities.m
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import "WeatherUtilities.h"

@implementation WeatherUtilities

//convert farneheit to celcius
+(double) farenheitToCelcius:(double)farenheitValue {
    
    return  (farenheitValue - 32)/1.8;
}

@end
