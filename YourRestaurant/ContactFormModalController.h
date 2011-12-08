//
//  ContactFormModalController.h
//  YourRestaurant
//
//  Created by Lee Machin on 16/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactFormModalController : UIViewControllerBase {
  UITextView *restaurantAddress;
  UILabel *restaurantName;
  UISegmentedControl *contactControl;
  NSDictionary *restaurantData;
}

@property (nonatomic, retain) IBOutlet UITextView *restaurantAddress;
@property (nonatomic, retain) IBOutlet UILabel *restaurantName;
@property (nonatomic, retain) IBOutlet UISegmentedControl *contactControl;
@property (nonatomic, copy) NSDictionary *restaurantData;

- (IBAction)hitSegmentedControl:(UISegmentedControl *)control;

@end
