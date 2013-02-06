//
//  MenuViewController.m
//  YourRestaurant
//
//  Created by Lee Machin on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

@implementation MenuViewController {
  NSMutableArray *menusArray;
}

@synthesize menus;
@synthesize shareButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (IBAction)shareButtonClicked:(UIBarButtonItem *)shareButton {
  [[SocialAppSheet alloc] loadShareActionSheetIntoViewController:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppApiUrl"], @"menu"];
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestUrl]];
  
  [request setCompletionBlock:^{
    NSData *response = [request responseData];
    NSArray *menuItems = [response yajl_JSON];  
    menusArray = [NSMutableArray arrayWithCapacity:[menuItems count]];
    
    for (NSDictionary *menuItem in menuItems) {
      Menu *menu = [[Menu alloc] init];
      [menu setName:[menuItem objectForKey:@"name"]];
      [menu setDescription:[menuItem objectForKey:@"description"]];
      [menu setCellIdentifier:[menuItem objectForKey:@"identifier"]];
      
      [menusArray addObject:menu];
      [menu release];
    }
    
    [self setMenus:menusArray];
    [[self tableView] reloadData];    
  }];
  
  [request setFailedBlock:^{
    NSError *error = [request error];
    NSLog(@"%@", error);    
  }];
  
  [request startAsynchronous];
  [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  NSLog(@"Doing a segue majingy: %@", [sender cellIdentifier]);
  MenuCourseViewController *menuCourseViewController = [segue destinationViewController];
  [menuCourseViewController setMenuId:[sender cellIdentifier]];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  [menusArray release];
  [menus release];
  menus = nil;
  menusArray = nil;
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
    return [[self menus] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
  
  Menu *menu = [[self menus] objectAtIndex:[indexPath row]];
  [[cell textLabel] setText: [menu name]];
  [[cell detailTextLabel] setText:[menu description]];
  [cell setCellIdentifier:[menu cellIdentifier]];

  CustomColouredAccessory *accessory = [CustomColouredAccessory accessoryWithColour:[UIColor brownColor]];
  [accessory setHighlightedColour:[UIColor blackColor]];
  
  [cell setAccessoryView: accessory];
  
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     DetailViewController *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
