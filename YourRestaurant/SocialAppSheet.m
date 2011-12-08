//
//  SocialAppSheet.m
//  YourRestaurant
//
//  Created by Lee Machin on 14/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SocialAppSheet.h"

@implementation SocialAppSheet
@synthesize sheet;
@synthesize vc;
@synthesize webView;

- (void)loadShareActionSheetIntoViewController:(UIViewController *)viewController {
  [super init];
  [self setVc:viewController];
  [self setSheet:[[[UIActionSheet alloc] initWithTitle:@"Find Us Online" delegate:self 
                                            cancelButtonTitle:@"No thanks" 
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"Facebook", @"Twitter", @"Google+", nil] autorelease]];
  
  [[self sheet] showInView:[[[self vc] navigationController] navigationBar]];  
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
   switch (buttonIndex) {
    case 0: // Facebook
       [self openPageFor:@"Facebook" withURL:[NSURL URLWithString:@"http://www.facebook.com"]];
      break;
      
    case 1: // Twitter
       [self openPageFor:@"Twitter" withURL:[NSURL URLWithString:@"http://www.twitter.com"]];
      break;
      
    case 2: // Google+
       [self openPageFor:@"Google Plus" withURL:[NSURL URLWithString:@"http://www.google.com"]];
      break;
  }
}

- (void)openPageFor:(NSString *)network withURL:(NSURL *)url {
  [self setWebView: [[[SocialWebViewController alloc] initWithNibName:@"SocialWebViewController" bundle:nil] autorelease]];
  [[self webView] setUrl:url];
  
  [[[self vc] navigationController] setModalPresentationStyle:UIModalPresentationFormSheet];
  [[[self vc] navigationController] setModalTransitionStyle:UIModalTransitionStylePartialCurl];
  [[[self vc] navigationController] presentModalViewController:[self webView] animated:YES];
}

- (void)closeBrowser {
  [[[self vc] navigationController] popToRootViewControllerAnimated:YES];
}

- (void)isReadyToDismiss {
  NSLog(@"Called!");
  [[[self vc] navigationController] dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
  self.sheet = nil;
  [super dealloc];
}


@end
