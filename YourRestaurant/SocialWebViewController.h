//
//  SocialWebViewController.h
//  YourRestaurant
//
//  Created by Lee Machin on 14/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



@protocol SocialWebViewDelegate;

@interface SocialWebViewController : UIViewControllerBase <UIWebViewDelegate> {
  UIWebView *webView;
  UINavigationBar *navBar;
  UIBarButtonItem *closeButton;
  UIActivityIndicatorView *activityIndicator;
  NSURL *url;
  id<SocialWebViewDelegate> delegate;
}

- (IBAction)closeButtonClicked:(UIBarButtonItem *)closeButton;

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *closeButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) NSURL *url;

@end

@protocol SocialWebViewDelegate <NSObject>

- (void)isReadyToDismiss;

@end