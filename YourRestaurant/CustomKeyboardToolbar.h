//
//  CustomKeyboardToolbar.h
//  YourRestaurant
//
//  Created by Lee Machin on 20/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomKeyboardToolbar : NSObject {
  UIBarButtonItem *doneButton;
  UIBarButtonItem *nextButton;
  UIBarButtonItem *previousButton;
  UIBarButtonItem *flex;
  UIToolbar *toolbar;
  
  id delegate;
}

@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UIBarButtonItem *nextButton;
@property (nonatomic, retain) UIBarButtonItem *previousButton;
@property (nonatomic, assign) id delegate;

- (id)initWithPresetButtons;
- (void)populateToolbar:(UIToolbar *)toolbar;

- (void)dismissKeyboard:(id)sender;
- (void)selectNextInput:(id)sender;
- (void)selectPreviousInput:(id)sender;

@end

@protocol CustomKeyboardToolbarDelegate <NSObject>

@required
- (void)didDismissKeyboard:(id)sender;
- (void)didSelectNextInput:(id)sender;
- (void)didSelectPreviousInput:(id)sender;

@end