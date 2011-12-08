//
//  MenuCourseViewController.h
//  YourRestaurant
//
//  Created by Lee Machin on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAJLiOS/YAJL.h"
#import "ASIHTTPRequest.h"
#import "CustomColouredAccessory.h"
#import "Dish.h"
#import "SocialAppSheet.h"

@interface MenuCourseViewController : UITableViewControllerBase {
  UIBarButtonItem *shareButton;
}

@property (nonatomic, copy) NSString *menuId;
@property (nonatomic, copy) NSMutableArray *dishes;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *shareButton;

- (IBAction)shareButtonClicked:(UIBarButtonItem *)shareButton;

@end
