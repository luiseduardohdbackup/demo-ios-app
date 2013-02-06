//
//  ContactFormViewController.m
//  YourRestaurant
//
//  Created by Lee Machin on 13/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactFormViewController.h"

@implementation ContactFormViewController

@synthesize shareButton;
@synthesize map;
@synthesize aboutRestaurant;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (IBAction)shareButtonClicked:(UIBarButtonItem *)shareButton {
  [[SocialAppSheet alloc] loadShareActionSheetIntoViewController:self];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
}

- (void)didSwipeLeft:(UISwipeGestureRecognizer *)swipeActionLeft {
  NSLog(@"left swipe");
}

- (void)didSwipeRight:(UISwipeGestureRecognizer *)swipeActionRight {
  NSLog(@"Right swipe");
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Gesture recognisers
- (void)addSwipeGestureRecognisersToView:(UIView *)view {
  UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(didSwipeLeft:)];
  [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
  [swipeLeft setNumberOfTouchesRequired:2];
  [swipeLeft setDelegate:self];
  [view addGestureRecognizer:swipeLeft];
  [swipeLeft release];

  UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(didSwipeRight:)];
  [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
  [swipeRight setNumberOfTouchesRequired:2];
  [swipeRight setDelegate:self];
  [view addGestureRecognizer:swipeRight];
  [swipeRight release];
}

#pragma mark - View lifecycle
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  ContactFormModalController *modal = [segue destinationViewController];
  [modal setRestaurantData:[sender aboutRestaurant]];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

  NSString *requestUrl = [NSString stringWithFormat:@"%s/%s", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppApiUrl"], 'about'];
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestUrl]];

  [request setCompletionBlock:^{
    NSData *response = [request responseData];

    [self setAboutRestaurant:[response yajl_JSON]];

    CLLocationCoordinate2D coord = {
      .latitude = [[[self aboutRestaurant] objectForKey:@"latitude"] doubleValue],
      .longitude = [[[self aboutRestaurant] objectForKey:@"longitude"] doubleValue]
    };

    MKCoordinateSpan span = {.latitudeDelta = 0.1, .longitudeDelta = 0.1};
    MKCoordinateRegion region = {coord, span};

    [[self map] removeAnnotations:[[self map] annotations]];


    MKMapAnnotation *annotation = [[MKMapAnnotation alloc]
                                   initWithName:[[self aboutRestaurant] objectForKey:@"name"]
                                   address:[[self aboutRestaurant] objectForKey:@"area"]
                                   coordinate:coord];
    [[self map] addAnnotation:annotation];
    [annotation release];
    [[self map] setRegion:region animated: YES];
  }];

  [request setFailedBlock:^{
    NSError *error = [request error];
    NSLog(@"%@", error);
  }];

  [request startAsynchronous];
  [self addSwipeGestureRecognisersToView:[self map]];
  [super viewDidLoad];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  [map release];
  [aboutRestaurant release];

  map = nil;
  aboutRestaurant = nil;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];
}

- (void)showMoreInfo:(UIButton *)sender {
  [self performSegueWithIdentifier:@"contactForm" sender:self];
}

#pragma mark - Map View Delegates
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  static NSString *identifier = @"restaurantLocation";

  if ([annotation isKindOfClass:[MKMapAnnotation class]]) {
    MKMapAnnotation *annotationLocation = (MKMapAnnotation *) annotation;
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [[self map] dequeueReusableAnnotationViewWithIdentifier:identifier];

    if (annotationView == nil) {
      annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotationLocation reuseIdentifier:identifier] autorelease];
    } else {
      [annotationView setAnnotation:annotationLocation];
    }

    [annotationView setEnabled:YES];
    [annotationView setCanShowCallout:YES];
    [annotationView setAnimatesDrop:YES];
    [annotationView setPinColor:MKPinAnnotationColorPurple];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fork-and-knife-white.png"]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button addTarget:self action:@selector(showMoreInfo:) forControlEvents:UIControlEventTouchUpInside];

    [annotationView setLeftCalloutAccessoryView:imageView];
    [annotationView setRightCalloutAccessoryView:button];

    [imageView release];
    imageView = nil;


    return annotationView;
  } else {
   return nil;
  }
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
  // we want to make sure that our pin is selected automatically. If we have to have multiple pins at some point,
  // we'll have to determine the one closest to the user's current location.
  [mapView selectAnnotation:[[mapView annotations] objectAtIndex:0] animated:YES];
}

#pragma mark - ASIHttpRequest Delegates
// don't use blocks here. We can assign more semantic delegates.

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
