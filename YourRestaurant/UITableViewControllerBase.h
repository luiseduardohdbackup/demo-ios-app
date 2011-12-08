//
//  UITableViewControllerBase.h
//  YourRestaurant
//
//  Created by Lee Machin on 15/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewControllerBase : UITableViewController

- (void)clearBackground;
- (void)addImage:(UIImage *)image toNavBarItem:(UINavigationItem *)navBarItem;

@end
