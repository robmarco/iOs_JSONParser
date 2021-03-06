//
//  NSURLConnectionViewController.h
//  JSONParserRM
//
//  Created by Roberto Marco on 21/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"

@interface NSURLConnectionViewController : UIViewController <NSURLConnectionDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSURLConnection *_connection;
@property (nonatomic, strong) NSMutableData *_responseData;
@property (weak, nonatomic) IBOutlet UITableView *tableData;

@end
