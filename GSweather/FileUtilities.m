//
//  FileUtilities.m
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import "FileUtilities.h"

@implementation FileUtilities

//returns a dictionary from a file, given a file name
+(NSDictionary*) dictionaryFromJSONFile:(NSString*)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *dataFile = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *serializedJSONData = [NSJSONSerialization JSONObjectWithData:dataFile options:kNilOptions error:nil];
    
    NSLog(@"JSON Data: %@", serializedJSONData);
    
    return serializedJSONData;
}

@end
