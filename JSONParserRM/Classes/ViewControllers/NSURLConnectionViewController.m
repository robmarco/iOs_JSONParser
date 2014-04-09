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
#import "LoanCell.h"
#import "UIKit+AFNetworking.h"

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
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kivaloans_logo2.png"]]];
    
    // Create table and set delegates
    [self.tableData setDelegate:self];
    [self.tableData setDataSource:self];
    [self.tableData setBackgroundColor:[UIColor blackColor]];


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
    LoanCell *cell = (LoanCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoanCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Loan *loan = [[Loan alloc] init];
    loan = [arrayLoan objectAtIndex:indexPath.row];
    
    [cell.labelCountry setText:loan.country];
    [cell.labelName setText:loan.name];
    [cell.labelDescription setText:loan.use];
    
    NSString *url = [NSString stringWithFormat:@"http://www.kiva.org/img/w80h80/%d.jpg", [loan.imageId intValue]];
    // with setImageWithURL (included in UIKit+AFNetworking) we can send an image request async
    [cell.imageCell setImageWithURL:[NSURL URLWithString:url]];
    [self maskRoundBorder:cell.imageCell color:[UIColor blackColor]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayLoan count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
                        
                        if ([dictLoan objectForKey:@"status"] != [NSNull null])
                            [loan setStatus:[dictLoan objectForKey:@"status"]];
                        
                        if ([dictLoan objectForKey:@"funded_amount"] != [NSNull null])
                            [loan setFunded_amount:[dictLoan objectForKey:@"funded_amount"]];
                        
                        if ([dictLoan objectForKey:@"basket_amount"] != [NSNull null])
                            [loan setBasket_amount:[dictLoan objectForKey:@"basket_amount"]];
                        
                        if ([[dictLoan objectForKey:@"image"] objectForKey:@"id"] != [NSNull null])
                            [loan setImageId:[[dictLoan objectForKey:@"image"] objectForKey:@"id"]];
                        
                        if ([[dictLoan objectForKey:@"location"] objectForKey:@"country"] != [NSNull null])
                            [loan setCountry:[[dictLoan objectForKey:@"location"] objectForKey:@"country"]];
                        
                        if ([dictLoan objectForKey:@"use"] != [NSNull null])
                            [loan setUse:[dictLoan objectForKey:@"use"]];
                        
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


#pragma mark Private Methods

- (void) maskRoundBorder:(UIView *)view color:(UIColor *)color {
    view.layer.cornerRadius = 10;
    view.clipsToBounds = YES;
}

@end
