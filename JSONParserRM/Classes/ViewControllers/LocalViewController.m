//
//  LocalViewController.m
//  JSONParserRM
//
//  Created by Roberto Marco on 25/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "LocalViewController.h"
#import "JsonParserSport.h"

@interface LocalViewController ()

@end

@implementation LocalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Local JSON"];
    
    arrayWithSportNews = [[NSMutableArray alloc] initWithCapacity:0];
    
    JsonParserSport *jsonParser = [[JsonParserSport alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Initializate JSON parser
        JSONDecoder *jsonDecoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionValidFlags];
        
        // Set the local JSON URL Path
        NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonExample" ofType:@"json"];
        NSData* jsonData = [NSData dataWithContentsOfFile:path];
        
        // Parsing Data and move data result into a dictionary
        NSDictionary *dict = [jsonDecoder objectWithData:jsonData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            arrayWithSportNews = [jsonParser parseLocalJSON:dict];
             NSLog(@"%@", arrayWithSportNews);
        });
    });
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
