//
//  NSURLConnectionViewController.m
//  JSONParserRM
//
//  Created by Roberto Marco on 21/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//
//      - Problem: Set flag -fno-objc-arc in JSONKit Build Path => Compile Source
//

#import "NSURLConnectionViewController.h"
#import "Loan.h"

@interface NSURLConnectionViewController ()

@end

@implementation NSURLConnectionViewController

@synthesize _responseData;
@synthesize _connection;

NSMutableArray *arrayLoan;

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
    [self setTitle:@"NSURLConnection"];
    
    // Create table and set delegates
    [self.tableData setDelegate:self];
    [self.tableData setDataSource:self];


    // Setting up URL
    NSURL *url = [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"];
    
    // Create request for connection
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Create the connection
    _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    // ensure the connection was created
    if (_connection)
    {
        // Initialize the buffer
        _responseData = [NSMutableData data];
        
        // start the request
        [_connection start];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.textLabel setText:[[arrayLoan objectAtIndex:indexPath.row] name]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayLoan count];
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    // Return nil to indicate not necessary to store a cache response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        NSError *error = nil;
        
        // Initializate JSON parser
        JSONDecoder *jsonDecoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionValidFlags];
        
        // Parsing Data and move data result into a dictionary
        NSDictionary *dict = [jsonDecoder objectWithData:_responseData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Check for a JSON error
            if (!error)
            {
                // Starting JSON Parser
                NSLog(@"--> dic: %@", dict);
                
                if ([dict objectForKey:@"loans"] != [NSNull null])
                {
                    // Initializate Loan Array
                    arrayLoan = [[NSMutableArray alloc] initWithCapacity:0];
                    
                    // Loop throw every block we find in the JSON
                    for (NSDictionary *dictLoan in [dict objectForKey:@"loans"])
                    {
                        Loan *loan = [[Loan alloc] init];
                        
                        if ([dictLoan objectForKey:@"id"] != [NSNull null])
                            [loan setId:[dictLoan objectForKey:@"id"]];
                        
                        if ([dictLoan objectForKey:@"name"] != [NSNull null])
                            [loan setName:[dictLoan objectForKey:@"name"]];
                        
                        [arrayLoan addObject:loan];                        
                    }
                }
                
                // Refresh table
                [self.tableData reloadData];
                
            } else {
                NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey]);
            }
            
            // Clear the connection and buffer
            _connection = nil;
            _responseData = nil;
            
        });
        
        
        
    });
}

@end
