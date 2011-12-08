//
//  CustomTableViewCell.m
//  YourRestaurant
//
//  Extend me for other goodness
//  Created by Lee Machin on 15/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UITableViewCellBase.h"

@implementation UITableViewCellBase

@synthesize cellIdentifier;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
  [cellIdentifier release];
  cellIdentifier = nil;
  [super dealloc];
}

@end
