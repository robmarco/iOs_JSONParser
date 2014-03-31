//
//  MainViewController.m
//  JSONParserRM
//
//  Created by Roberto Marco on 31/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "MainViewController.h"
#import "NSURLConnectionViewController.h"
#import "ASIViewController.h"
#import "LocalViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBActions

- (IBAction)pushASIHttp:(id)sender {
    ASIViewController *asiViewController = [[ASIViewController alloc] initWithNibName:@"ASIViewController" bundle:nil];
    
    [self.navigationController pushViewController:asiViewController animated:YES];
}

- (IBAction)pushLocal:(id)sender {
    LocalViewController *localViewController = [[LocalViewController alloc] initWithNibName:@"LocalViewController" bundle:nil];
    [self.navigationController pushViewController:localViewController animated:YES];
}

- (IBAction)pushNSURLConn:(id)sender {
    NSURLConnectionViewController *nsurlViewController = [[NSURLConnectionViewController alloc] initWithNibName:@"NSURLConnectionViewController" bundle:nil];
    [self.navigationController pushViewController:nsurlViewController animated:YES];
}

@end
