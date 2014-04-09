//
//  JsonParserSport.m
//  JSONParserRM
//
//  Created by Roberto Marco on 31/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "JsonParserSport.h"

@implementation JsonParserSport

#pragma mark - Public Methods

- (NSMutableArray *)parseRemoteJSON:(ASIHTTPRequest *)requestCon {
    
    // Init JSON parser
    JSONDecoder *jsonDecoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionValidFlags];

    // Parsing the data obtaining the data in a dictionary
    NSDictionary *dic = [jsonDecoder objectWithData:[requestCon responseData]];
    
    return [self parseDataToArray:dic];;
}

- (NSMutableArray *)parseLocalJSON {
    
    // Initializate JSON parser
    JSONDecoder *jsonDecoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionValidFlags];
    
    // Set the local JSON URL Path
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonExample" ofType:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfFile:path];
    
    // Parsing Data and move data result into a dictionary
    NSDictionary *dict = [jsonDecoder objectWithData:jsonData];

    return [self parseDataToArray:dict];;
}

#pragma mark - Private Methods

- (NSMutableArray *) parseDataToArray:(NSDictionary*)dic {
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([dic objectForKey:@"headlines"] != [NSNull null])
    {
        for (NSDictionary *dicHeadLines in [dic objectForKey:@"headlines"])
        {
            SportNew *sportNew = [[SportNew alloc] init];
            
            if ([dicHeadLines objectForKey:@"headline"] != nil)
                [sportNew setHeadline:[dicHeadLines objectForKey:@"headline"]];
            
            if ([dicHeadLines objectForKey:@"title"] != nil)
                [sportNew setTitle:[dicHeadLines objectForKey:@"title"]];
            
            if ([dicHeadLines objectForKey:@"description"] != nil)
                [sportNew setDescription:[dicHeadLines objectForKey:@"description"]];
            
            if ([dicHeadLines objectForKey:@"links"] != nil) {
                
                NSDictionary *mobileLink = [[NSDictionary alloc] initWithDictionary:[[dicHeadLines objectForKey:@"links"]  objectForKey:@"mobile"]];
                
                [sportNew setMobileLink:[mobileLink objectForKey:@"href"]];
                
            }
            
            if ([dicHeadLines objectForKey:@"categories"] != nil) {
                NSArray *categories = [dicHeadLines objectForKey:@"categories"];
                [sportNew setCategory:[[categories objectAtIndex:0] objectForKey:@"description"]];
            }
            
            if ([dicHeadLines objectForKey:@"source"] != nil) {
                [sportNew setAuthor:[dicHeadLines objectForKey:@"source"]];
            }
            
            if ([dicHeadLines objectForKey:@"published"] != nil) {
                
                NSString *dateStr = [dicHeadLines objectForKey:@"published"];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
                NSDate *date = [dateFormat dateFromString:dateStr];
                [sportNew setDate:date];
            }
            
            if ([dicHeadLines objectForKey:@"images"] != nil)
            {
                NSMutableArray *arrayImagesParsed = [[NSMutableArray alloc] initWithCapacity:0];
                NSArray *arrayImages = [dicHeadLines objectForKey:@"images"];
                for (NSDictionary *image in arrayImages)
                {
                    [arrayImagesParsed addObject:image];
                }
                [sportNew.images addObjectsFromArray:arrayImagesParsed];
            }
            
            [array addObject:sportNew];
        }
    }
    
    return array;
}


@end
