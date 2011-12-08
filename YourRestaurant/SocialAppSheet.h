//
//  SocialAppSheet.h
//  YourRestaurant
//
//  Created by Lee Machin on 14/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SocialWebViewController.h"

@interface SocialAppSheet : NSObject<UIActionSheetDelegate> {
  UIActionSheet *sheet;
  UIViewController *vc;
  SocialWebViewController *webView;
}

@property (nonatomic, retain) UIActionSheet *sheet;
@property (nonatomic, retain) UIViewController *vc;
@property (nonatomic, retain) SocialWebViewController *webView;

- (void)loadShareActionSheetIntoViewController:(UIViewController *)viewController;
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)openPageFor:(NSString *)network withURL:(NSURL *)url;
- (void)closeBrowser;

@end
