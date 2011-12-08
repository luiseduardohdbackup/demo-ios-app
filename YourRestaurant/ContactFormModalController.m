//
//  ContactFormModalController.m
//  YourRestaurant
//
//  Created by Lee Machin on 16/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactFormModalController.h"

@implementation ContactFormModalController
@synthesize restaurantName;
@synthesize restaurantAddress;
@synthesize restaurantData;
@synthesize contactControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated {
  NSString *address = [[[self restaurantData] objectForKey:@"address"] stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
  
  [[self restaurantName] setText:[[self restaurantData] objectForKey:@"name"]];
  [[self restaurantAddress] setText:address];
  [super viewWillAppear:YES];
}

- (IBAction)hitSegmentedControl:(UISegmentedControl *)control {
  switch ([control selectedSegmentIndex]) {
    case 0: // Call
      [[UIApplication sharedApplication] 
       openURL:[NSURL 
                URLWithString:[@"tel://" 
                               stringByAppendingString:[[self restaurantData] objectForKey:@"phone"]]]];
      break;
    case 1: // Email
      break;
  }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
