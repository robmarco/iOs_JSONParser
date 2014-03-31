//
//  SportNew.h
//  JSONParserRM
//
//  Created by Roberto Marco on 25/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SportNew : NSObject

@property (nonatomic, strong) NSString *headline;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *mobileLink;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *author;

- (NSInteger) getDaysFromToday;

@end
