//
//  LocalViewController.m
//  JSONParserRM
//
//  Created by Roberto Marco on 25/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "LocalViewController.h"
#import "JsonParserSport.h"
#import "CustomCell.h"
#import <QuartzCore/QuartzCore.h>

@interface LocalViewController ()

@end

@implementation LocalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Navigation Bar Configuration
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationbar_bg.png"]]];
    
    arrayWithSportNews = [[NSMutableArray alloc] initWithCapacity:0];
    JsonParserSport *jsonParser = [[JsonParserSport alloc] init];
    arrayWithSportNews = [jsonParser parseLocalJSON];
    
    [self.tableLocal setBackgroundColor:[UIColor blackColor]];
    [self.tableLocal setDelegate:self];
    [self.tableLocal setDataSource:self];
    
    
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

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

#pragma mark UITableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Private Methods

- (void) maskRoundBorder:(UIView *)view color:(UIColor *)color {
    view.layer.cornerRadius = 10;
    view.clipsToBounds = YES;
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = 0.5;
}

@end
