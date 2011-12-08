//
//  SocialWebViewController.m
//  YourRestaurant
//
//  Created by Lee Machin on 14/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SocialWebViewController.h"

@implementation SocialWebViewController
@synthesize webView;
@synthesize url;
@synthesize navBar;
@synthesize closeButton;
@synthesize activityIndicator;

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

#pragma mark - Webview Delegates
- (void)webViewDidStartLoad:(UIWebView *)webView {
  [[self activityIndicator] setHidden:NO];
  [[self activityIndicator] startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  NSLog(@"Finish load called");
  [[self activityIndicator] setHidden:YES];
  [[self activityIndicator] stopAnimating];
}

#pragma mark - View lifecycle

- (IBAction)closeButtonClicked:(UIBarButtonItem *)closeButton {
    [delegate isReadyToDismiss];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{   
  [self addImage:[UIImage imageNamed:@"logo.png"] toNavBarItem:[[self navBar]topItem]];
  
  [[self webView] loadRequest:[NSURLRequest requestWithURL:[self url]]];
  [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [webView release];
    [url release];
    webView = nil;
    url = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
