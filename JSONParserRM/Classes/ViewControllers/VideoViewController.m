//
//  VideoViewController.m
//  JSONParserRM
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewDidAppear:(BOOL)animated {
    self.movieController = [[MPMoviePlayerController alloc] init];
    self.movieURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://movietrailers.apple.com/movies/summit/twilightbreakingdawn1/twilightbreakingdawn-clip1_480p.mov?width=%f&height=%f", self.view.frame.size.width, self.view.frame.size.height]];
    
    [self.movieController setContentURL:self.movieURL];
    [self.movieController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.movieController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.movieController];
    
    [self.movieController play];
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [self.movieController stop];
}

@end
