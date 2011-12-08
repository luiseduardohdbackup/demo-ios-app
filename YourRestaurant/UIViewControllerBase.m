//
//  UIViewControllerBase.m
//  YourRestaurant
//
//  Created by Lee Machin on 15/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIViewControllerBase.h"

@implementation UIViewControllerBase

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [self clearBackground];
  [self addImage:[UIImage imageNamed:@"logo.png"] toNavBarItem:[self navigationItem]];
  [super viewDidLoad];
}

- (void)clearBackground {
  [[self view] setBackgroundColor:[UIColor clearColor]];
}

- (void)addImage:(UIImage *)image toNavBarItem:(UINavigationItem *)navBarItem {
  UIImageView *logo = [[UIImageView alloc] initWithImage:image];  
  [navBarItem setTitleView:logo];
  [logo release];
}

@end
