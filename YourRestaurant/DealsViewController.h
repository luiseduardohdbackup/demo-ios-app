//
//  DealsViewController.h
//  YourRestaurant
//
//  Created by Lee Machin on 08/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAJLiOS/YAJL.h"
#import "ASIHTTPRequest.h"
#import "Deal.h"
#import "CustomColouredAccessory.h"
#import "SocialAppSheet.h"

@interface DealsViewController : UITableViewControllerBase {
  UIBarButtonItem *shareButton;
}

@property (nonatomic, strong) NSMutableArray *deals;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *shareButton;

- (IBAction)shareButtonClicked:(UIBarButtonItem *)shareButton;


@end
