//
//  BookingFormController.h
//  YourRestaurant
//
//  Created by Lee Machin on 19/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialAppSheet.h"
#import "BookingFormField.h"
#import "CustomKeyboardToolbar.h"
#import "BookingFormModel.h"
#import "BookingFormTextField.h"

@interface BookingFormController : UITableViewControllerBase <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CustomKeyboardToolbarDelegate> {
  UIBarButtonItem *shareButton;
  UIDatePicker *bookingDatePicker;
  UIPickerView *bookingPartyPicker;
  BookingFormModel *bookingData;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *shareButton;
@property (nonatomic, retain) IBOutlet UIDatePicker *bookingDatePicker;
@property (nonatomic, retain) IBOutlet UIPickerView *bookingPartyPicker;
@property (nonatomic, copy) NSMutableArray *bookingFormFields;

- (IBAction)shareButtonClicked:(UIBarButtonItem *)shareButton;
- (IBAction)bookingDatePickerSelectedDate:(UIDatePicker *)datePicker;

- (void)populateFormData;
- (void)didTapSaveButton:(UIButton *)button;

@end
