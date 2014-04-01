//
//  VideoViewController.h
//  JSONParserRM
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoViewController : UIViewController

@property (copy, nonatomic) NSURL *movieURL;
@property (strong, nonatomic) MPMoviePlayerController *movieController;

@end
