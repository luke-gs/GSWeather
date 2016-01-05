//
//  FileUtilities.h
//  GSweather
//
//  Created by Luke sammut on 5/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtilities : NSObject

+(NSDictionary*) dictionaryFromJSONFile:(NSString*)fileName;

@end
