//
//  ContactFormViewController.h
//  YourRestaurant
//
//  Created by Lee Machin on 13/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ASIHTTPRequest.h"
#import "YAJLiOS/YAJL.h"
#import "SocialAppSheet.h"
#import "MKMapAnnotation.h"
#import "ContactFormModalController.h"

@interface ContactFormViewController : UIViewControllerBase <MKMapViewDelegate,UIGestureRecognizerDelegate> {
  UIBarButtonItem *shareButton;
  MKMapView *map;
  NSDictionary *aboutRestaurant;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *shareButton;
@property (nonatomic, retain) IBOutlet MKMapView *map;
@property (nonatomic, copy) NSDictionary *aboutRestaurant;

- (IBAction)shareButtonClicked:(UIBarButtonItem *)shareButton;
- (void)showMoreInfo:(UIButton *)sender;
- (void)didSwipeLeft:(UISwipeGestureRecognizer *)swipeActionLeft;
- (void)didSwipeRight:(UISwipeGestureRecognizer *)swipeActionRight;
- (void)addSwipeGestureRecognisersToView:(UIView *)view;

@end
