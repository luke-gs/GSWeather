//
//  UIFont+Extended.m
//  GSweather
//
//  Created by Luke sammut on 4/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import "UIFont+Extended.h"

@implementation UIFont (Extended)

+(UIFont*) weatherTitleFont
{
    return [UIFont systemFontOfSize:60 weight:UIFontWeightThin];
}
+(UIFont*) smallTitleFont
{
    return [UIFont systemFontOfSize:22 weight:UIFontWeightThin];
}
+(UIFont*) screenTitleFont
{
    return [UIFont systemFontOfSize:24];
}
+(UIFont*) cellFont
{
    return [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
}

@end
