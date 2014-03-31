//
//  SportNew.m
//  JSONParserRM
//
//  Created by Roberto Marco on 25/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "SportNew.h"

@implementation SportNew

@synthesize headline;
@synthesize title;
@synthesize description;
@synthesize date;
@synthesize images;
@synthesize mobileLink;
@synthesize category;
@synthesize author;

- (id) init
{
    if (self == [super init])
    {
        images = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

-(NSInteger) getDaysFromToday
{
    NSDate *date1 = [NSDate date];
    NSDate *date2 = date;
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:date2
                                                  toDate:date1 options:0];
    
    return [components day] + [components month]*30;
}

@end
