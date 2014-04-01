//
//  DetailViewController.m
//  JSONParserRM
//
//  Created by Roberto Marco on 31/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "DetailViewController.h"
#import "WebDetailViewController.h"
#import "VideoViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize sportNew;

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
    
    // Loading data into View
    [self.labelCategory setText:[sportNew category]];
    [self.labelTitle setText:[sportNew title]];
    [self.labelAuthor setText:[sportNew author]];
    [self.labelDescription setText:[sportNew description]];
    [self.labelDate setText:[NSString stringWithFormat:@"Hace %d días",[sportNew getDaysFromToday]]];
    
    if (sportNew.images.count > 0) {
        NSString *urlImage = [[sportNew.images objectAtIndex:0] objectForKey:@"url"];
        [self setRemoteImage:self.imageDetail url:urlImage];
    } else
        [self.imageDetail setImage:[UIImage imageNamed:@"main_background.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBAction

- (IBAction)pushVideo:(id)sender {
    VideoViewController *videoVC = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:nil];
    [self.navigationController pushViewController:videoVC animated:YES];
}

- (IBAction)pushWebSite:(id)sender {
    WebDetailViewController *webDetailVC = [[WebDetailViewController alloc] initWithNibName:@"WebDetailViewController" bundle:nil];
    [webDetailVC setUrl:[sportNew mobileLink]];    
    
    [self.navigationController pushViewController:webDetailVC animated:YES];
}

#pragma mark Private Methods

- (void) setRemoteImage:(UIImageView*)imageView url:(NSString*)imageUrl {
    NSString *urlImage;
    
    if (imageUrl == nil)
        urlImage = @"https://lh4.googleusercontent.com/-yOoKXdob9y8/AAAAAAAAAAI/AAAAAAABGIQ/nyeQkhOGgg8/s150-c/photo.jpg";
    else
        urlImage = imageUrl;
    
    // Get Image in Async Mode
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:
                                                  [NSURL  URLWithString:urlImage]]];
        dispatch_sync(dispatch_get_main_queue(),^ {
            // Run in main thread
            [imageView setImage:image];
        });
    });
}


@end
