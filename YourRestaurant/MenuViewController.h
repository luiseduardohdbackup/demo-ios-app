//
//  MenuViewController.h
//  YourRestaurant
//
//  Created by Lee Machin on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAJLiOS/YAJL.h"
#import "ASIHTTPRequest.h"
#import "MenuCourseViewController.h"
#import "CustomColouredAccessory.h"
#import "MenuTableViewCell.h"
#import "Menu.h"
#import "SocialAppSheet.h"

@interface MenuViewController : UITableViewControllerBase {
  UIBarButtonItem *shareButton;
}

@property (nonatomic, strong) NSMutableArray *menus;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *shareButton;

- (IBAction)shareButtonClicked:(UIBarButtonItem *)shareButton;


@end
