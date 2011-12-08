//
//  BookingFormModel.m
//  YourRestaurant
//
//  Created by Lee Machin on 20/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BookingFormModel.h"

@implementation BookingFormModel

@synthesize firstName, 
            lastName, 
            phoneNumber, 
            emailAddress, 
            partySize,  
            bookingDate,
            dirty,
            delegate;

- (id)init {
  self = [super init];
  if (self) {
    self.dirty = YES;
  }  
  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"First Name: %@ \n Last Name: %@ \n Phone: %@ \n Email: %@ \n Party: %@ \n Date: %@",
          self.firstName, self.lastName, self.phoneNumber, self.emailAddress, self.partySize, self.bookingDate];
}

- (void)persist {
  NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
  ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
  [request setDelegate:self];
  [request setDidFinishSelector:@selector(bookingSent:)];
  [request setDidFailSelector:@selector(bookingFailed:)];
  
  [request setPostValue:self.firstName forKey:@"firstName"];
  [request setPostValue:self.lastName forKey:@"lastName"];
  [request setPostValue:self.phoneNumber forKey:@"phoneNumber"];
  [request setPostValue:self.emailAddress forKey:@"emailAddress"];
  [request setPostValue:self.partySize forKey:@"bookingDate"]; 
  
  [request startAsynchronous];
}

- (void)persistLocally {
  // runs when the latter fails or if we encounter some sort of early quit.
}

# pragma mark - ASIHttpRequest Delegates
- (void)bookingSent:(ASIHTTPRequest *)request {
  NSLog(@"sent!");
  // delegate this in future
  UIAlertView *successMessage = [[UIAlertView alloc] initWithTitle:@"Thanks!"
                                                           message:@"Your booking has been received" 
                                                          delegate:nil 
                                                 cancelButtonTitle:@"Close" 
                                                 otherButtonTitles:nil];
  [successMessage show];
  [successMessage release];
}

// if fails persist locally before doing anything else
- (void)bookingFailed:(ASIHTTPRequest *)request {
  NSLog(@"save offline");
  [self persistLocally];
}

- (void)dealloc {
  if (self.dirty == YES) {
    [self persistLocally];
  }
  
  [firstName release];
  [lastName release];
  [phoneNumber release];
  [emailAddress release];
  [partySize release];
  [bookingDate release];
  [super dealloc];
}

@end