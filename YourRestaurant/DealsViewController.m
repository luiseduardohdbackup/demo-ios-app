//
//  DealsViewController.m
//  YourRestaurant
//
//  Created by Lee Machin on 08/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DealsViewController.h"

@implementation DealsViewController {
  NSMutableArray *dealsArray;
}

@synthesize deals;
@synthesize shareButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)shareButtonClicked:(UIBarButtonItem *)shareButton {
  [[SocialAppSheet alloc] loadShareActionSheetIntoViewController:self];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{     
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://madefamousby.me/tom101/offers"]];
  
  // this runs when the request completes
  [request setCompletionBlock:^{
    NSData *response = [request responseData];
    NSArray *dealItems = [response yajl_JSON];
    
    dealsArray = [NSMutableArray arrayWithCapacity:[dealItems count]];
    
    for (NSDictionary *dealItem in dealItems) {
      Deal *deal = [[Deal alloc] init];
      [deal setName: [dealItem objectForKey:@"name"]];
      [deal setDescription: [dealItem objectForKey:@"description"]];
      
      [dealsArray addObject:deal];
      [deal release];
    }    
    [self setDeals:dealsArray];
    [[self tableView] reloadData];
  }];
  
  [request setFailedBlock:^{
    NSError *error = [request error];
    NSLog(@"%@", error); 
  }];
  
  [request startAsynchronous];
  [super viewDidLoad];
}

- (void)viewDidUnload
{
  [dealsArray release];
  deals = nil;
  [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self deals] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealCell"];
  
  Deal *deal = [[self deals] objectAtIndex:[indexPath row]];
  
  [[cell textLabel] setText:[deal name]];
  [[cell detailTextLabel] setText:[deal description]];
  
  CustomColouredAccessory *accessory = [CustomColouredAccessory accessoryWithColour:[UIColor brownColor]];
  [accessory setHighlightedColour:[UIColor blackColor]];
  
  [cell setAccessoryView: accessory];
  
  return cell;
}

#pragma mark - ASIHttpRequest Delegates
// don't use blocks here. We can assign more semantic delegates.

@end
