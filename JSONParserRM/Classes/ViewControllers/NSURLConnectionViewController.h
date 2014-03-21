//
//  NSURLConnectionViewController.h
//  JSONParserRM
//
//  Created by Roberto Marco on 21/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"

@interface NSURLConnectionViewController : UIViewController <NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLConnection *_connection;
@property (nonatomic, strong) NSMutableData *_responseData;

@end
