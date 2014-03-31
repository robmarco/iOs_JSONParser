//
//  LocalViewController.m
//  JSONParserRM
//
//  Created by Roberto Marco on 25/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "LocalViewController.h"
#import "Loan.h"

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
    
    [self parseLocalJSONAsync];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Methods

- (void) parseLocalJSONAsync {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Initializate JSON parser
        JSONDecoder *jsonDecoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionValidFlags];
        
        // Set the local JSON URL Path
        NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonExample" ofType:@"json"];
        NSData* jsonData = [NSData dataWithContentsOfFile:path];
        
        // Parsing Data and move data result into a dictionary
        NSDictionary *dict = [jsonDecoder objectWithData:jsonData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Starting JSON Parser
            NSLog(@"--> dic: %@", dict);
            
            if ([dict objectForKey:@"loans"] != [NSNull null])
            {
                // Initializate Loan Array
                arrayData = [[NSMutableArray alloc] initWithCapacity:0];
                
                // Loop throw every block we find in the JSON
                for (NSDictionary *dictLoan in [dict objectForKey:@"loans"])
                {
                    Loan *loan = [[Loan alloc] init];
                    
                    if ([dictLoan objectForKey:@"id"] != [NSNull null])
                        [loan setId:[dictLoan objectForKey:@"id"]];
                    
                    if ([dictLoan objectForKey:@"name"] != [NSNull null])
                        [loan setName:[dictLoan objectForKey:@"name"]];
                    
                    [arrayData addObject:loan];
                }
            }
            
            // Refresh table
            //[self.tableData reloadData];
        
        });
    });
}

@end
