//
//  CustomKeyboardToolbar.m
//  YourRestaurant
//
//  Created by Lee Machin on 20/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomKeyboardToolbar.h"

@implementation CustomKeyboardToolbar
@synthesize toolbar;
@synthesize nextButton;
@synthesize previousButton;
@synthesize delegate;

- (id)initWithPresetButtons {
  self = [super init];
   
  if (self) {
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [self populateToolbar:toolbar];
  }
  return self;
}

- (void)populateToolbar:(UIToolbar *)bar {
   
  doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                style:UIBarButtonItemStyleDone 
                                              target:self
                                               action:@selector(dismissKeyboard:)];
  
  self.nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" 
                                                     style:UIBarButtonItemStyleBordered 
                                                    target:self 
                                                    action:@selector(selectNextInput:)];
  
  self.previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous"
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self
                                                        action:@selector(selectPreviousInput:)];
  
  flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                       target:nil
                                                       action:nil];
  
  [bar setItems:[NSArray arrayWithObjects:
                     doneButton,
                     flex,
                     self.previousButton,
                     self.nextButton,
                     nil]
           animated:YES];
}

- (void)dismissKeyboard:(id)sender {
  if ([[self delegate] respondsToSelector:@selector(didDismissKeyboard:)]) {
    [[self delegate] didDismissKeyboard:sender];
  }
}

- (void)selectNextInput:(id)sender {
  if ([[self delegate] respondsToSelector:@selector(didSelectNextInput:)]) {
    [[self delegate] didSelectNextInput:sender];
  }
}

- (void)selectPreviousInput:(id)sender {
  if ([[self delegate] respondsToSelector:@selector(didSelectPreviousInput:)]) {
    [[self delegate] didSelectPreviousInput:sender];
  }
}

- (void)dealloc {
  [toolbar release];
  toolbar = nil;
  [doneButton release];
  doneButton = nil;
  [nextButton release];
  nextButton = nil;
  [previousButton release];
  previousButton = nil;
  [flex release];
  flex = nil;
  [super dealloc];
}

@end
