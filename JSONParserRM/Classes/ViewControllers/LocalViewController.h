//
//  LocalViewController.h
//  JSONParserRM
//
//  Created by Roberto Marco on 25/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *arrayWithSportNews;
}

@property (weak, nonatomic) IBOutlet UITableView *tableLocal;
@end
