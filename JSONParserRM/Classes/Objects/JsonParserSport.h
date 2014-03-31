//
//  JsonParserSport.h
//  JSONParserRM
//
//  Created by Roberto Marco on 31/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SportNew.h"
#import "JSONKit.h"

@interface JsonParserSport : NSObject

- (NSMutableArray *)parseJson:(ASIHTTPRequest*)requestCon;

@end
