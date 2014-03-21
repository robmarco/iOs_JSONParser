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

@interface NSURLConnectionViewController ()

@end

@implementation NSURLConnectionViewController

@synthesize _responseData;
@synthesize _connection;

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
    [self setTitle:@"JSONParser"];
    
    // Create table and set delegates
    
    // Setting up URL
    NSURL *url = [NSURL URLWithString:@""];
    
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

#pragma mark - NSURLConnection Delegate

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
                
                if ([dict objectForKey:@"comunidades"] != [NSNull null])
                {
                    // Initializate Cities Array
                    // arrayCiudad = [[NSMutableArray] alloc] initWithCapacity:0];
                    
                    // Loop throw every block we find in the JSON
                    for (NSDictionary *dictCity in [dict objectForKey:@"comunidades"])
                    {
                        //Creamos un objeto con la informacion parseada para añadirlo al array
//                        Comunidad *comunidad=[[Comunidad alloc]initComunidad];
//                        
//                        if ([dictCity objectForKey:@"nombre"]!=[NSNull null])
//                            [comunidad setNombre:[dictCity objectForKey:@"nombre"]];
//                        
//                        if ([dictCity objectForKey:@"superficie"]!=[NSNull null])
//                            [comunidad setSuperficie:[[dictCity objectForKey:@"superficie"] intValue]];
//                        
//                        if ([dictCity objectForKey:@"porcentaje"]!=[NSNull null])
//                            [comunidad setPorcentaje:[[dictCity objectForKey:@"porcentaje"] floatValue]];
//                        
//                        [arrayCiudad addObject:comunidad];
                    }
                }
                
                // Refresh table
                // [tableExample reloadData];
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
