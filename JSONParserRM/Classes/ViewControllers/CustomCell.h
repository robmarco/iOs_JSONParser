//
//  CustomCell.h
//  JSONParserRM
//
//  Created by Roberto Marco on 26/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (nonatomic, weak) IBOutlet UILabel *labelCategory;
@property (nonatomic, weak) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelAuthor;

@end
