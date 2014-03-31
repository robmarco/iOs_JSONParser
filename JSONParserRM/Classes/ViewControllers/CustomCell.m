//
//  CustomCell.m
//  JSONParserRM
//
//  Created by Roberto Marco on 26/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
