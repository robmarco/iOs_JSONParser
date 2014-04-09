//
//  ASIViewController.m
//  JSONParserRM
//
//  Created by Roberto Marco on 25/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "ASIViewController.h"
#import "CustomCell.h"
#import "JsonParserSport.h"
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ASIViewController ()
@end

@implementation ASIViewController



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
    
    // Navigation Bar Configuration
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationbar_bg.png"]]];
    
    // tableNews Configuration
    //[self.tableNews setBackgroundColor:[UIColor colorWithRed:233/255.0f green:234/255.0f blue:236/255.0f alpha:1]];
    [self.tableNews setBackgroundColor:[UIColor blackColor]];
    [self.tableNews setDelegate:self];
    [self.tableNews setDataSource:self];
    
    // Create RequestConnection withe GET method, because it wont receive parameters
    NSURL *url = [NSURL URLWithString:@"http://api.espn.com/v1/fantasy/football/news?apikey=9b9t99wj3q3an2s6d28bkfz5"];
    requestConnection = [ASIFormDataRequest requestWithURL:url];
    [requestConnection setRequestMethod:@"GET"];
    
    // Setting RequestConnection Time
    [requestConnection setTimeOutSeconds:10.0f];
    [requestConnection setDelegate:self];
    [requestConnection startAsynchronous];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView DataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CellIdentifier";
    
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell.labelTitle setText:[[arrayWithSportNews objectAtIndex:indexPath.row] title]];
    [cell.labelDescription setText:[NSString stringWithFormat:@"Hace %d días", [[arrayWithSportNews objectAtIndex:indexPath.row] getDaysFromToday]]];
    [cell.labelCategory setText:[[arrayWithSportNews objectAtIndex:indexPath.row] category]];
    [cell.labelAuthor setText:[[arrayWithSportNews objectAtIndex:indexPath.row] author]];
    [cell.labelNumber setText:[NSString stringWithFormat:@"%d",indexPath.row+1]];
    
    [self maskRoundBorder:cell.labelNumber color:cell.labelNumber.textColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayWithSportNews count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

#pragma mark UITableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [detailViewController setSportNew:[arrayWithSportNews objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark ASIHTTPRequest Delegate Methods

- (void) requestFinished:(ASIHTTPRequest *)request
{
    
#if DEBUG
    NSLog(@"Request status: %d", [request responseStatusCode]);
#endif
    
    switch ([request responseStatusCode]) {
        case 200:
        {
            JsonParserSport *jsonParser = [[JsonParserSport alloc] init];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                arrayWithSportNews = [jsonParser parseRemoteJSON:request];
                [self.tableNews performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            });
            
            break;
        }
            
        default:
        {
            NSLog(@"Connection Error: %@", [request responseString]);
            break;
        }
    }
}

- (void) requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"Request Error: %@", [request responseString]);
}

#pragma mark Private Methods

- (void) maskRoundBorder:(UIView *)view color:(UIColor *)color {
    view.layer.cornerRadius = 10;
    view.clipsToBounds = YES;
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = 0.5;    
}

@end
