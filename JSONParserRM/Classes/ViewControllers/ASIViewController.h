//
//  ASIViewController.h
//  JSONParserRM
//
//  Created by Roberto Marco on 25/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface ASIViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate>
{
    NSMutableArray *arrayWithSportNews;
    ASIHTTPRequest *requestConnection;
}

@property (weak, nonatomic) IBOutlet UITableView *tableNews;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end
