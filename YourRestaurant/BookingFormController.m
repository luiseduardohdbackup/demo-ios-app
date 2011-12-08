//
//  BookingFormController.m
//  YourRestaurant
//
//  Created by Lee Machin on 19/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BookingFormController.h"

#define bookingPickerMinPartySize 1
#define bookingPickerMaxPartySize 10


@implementation BookingFormController {
  BookingFormTextField *currentActiveField;
}
@synthesize shareButton;
@synthesize bookingFormFields;
@synthesize bookingDatePicker;
@synthesize bookingPartyPicker;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
      [[self tableView] setSeparatorColor:[UIColor colorWithRed:82/255.0 green:80/255.0 blue:78/255.0 alpha:1]];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (IBAction)shareButtonClicked:(UIBarButtonItem *)shareButton {
  [[SocialAppSheet alloc] loadShareActionSheetIntoViewController:self];
}

- (void)populateFormData {
  NSString *fieldsList = [[NSBundle mainBundle] pathForResource:@"bookingFormFields" ofType:@"plist"];
  NSMutableArray *formData = [NSMutableArray arrayWithContentsOfFile:fieldsList];
  NSMutableArray *formFields = [NSMutableArray arrayWithCapacity:[formData count]];
  
  for (NSDictionary *field in formData) {
    BookingFormField *formField = [[BookingFormField alloc] init];    
    [formField setName:[field objectForKey:@"fieldName"]];
    [formField setPlaceholder:[field objectForKey:@"placeholder"]];
    [formField setIdentifier:[field objectForKey:@"identifier"]];
    [formField setEditable:[[field objectForKey:@"editable"] boolValue]];
    [formField setType:[field objectForKey:@"type"]];
    
    [formFields addObject:formField];
    [formField release];
  }
  
  [self setBookingFormFields:formFields];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self populateFormData];
  // stores our data
  bookingData = [[BookingFormModel alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookingFormField"];
  NSInteger tag = [indexPath row]+1;
  
  BookingFormField *field = [bookingFormFields objectAtIndex:[indexPath row]]; // this isn't an assignment, so the retain count doesn't go up.
  
  BookingFormTextField *textField = [[BookingFormTextField alloc] initWithFrame:CGRectMake(140,13,165,30)];
  [textField setDelegate:self];
  [textField setAdjustsFontSizeToFitWidth:YES];
  [textField setFont:[UIFont systemFontOfSize:15.0]];
  [textField setTextColor:[UIColor whiteColor]];
  [textField setReturnKeyType:UIReturnKeyNext];
  [textField setIdentifier:[field identifier]];  
  [textField setTag:tag];
  
  if ([bookingData valueForKey:[field identifier]] != nil) {
    [textField setText:[bookingData valueForKey:[field identifier]]];
  }  
  
  CustomKeyboardToolbar *keyboardBar = [[CustomKeyboardToolbar alloc] initWithPresetButtons];  
  [keyboardBar setDelegate:self];
  
  // disable next/prev button where necessary
  if (tag == 1) {
    [[keyboardBar previousButton] setEnabled:NO];
  } else if (tag == [bookingFormFields count]) {
    [[keyboardBar nextButton] setEnabled:NO];
  }
  
  [textField setInputAccessoryView:[keyboardBar toolbar]];
 
  // change our keyboard types. For dates and number pickers, this means changing the view.
  // For everything else, we're just changing one of the built in ones.
  if ([[field type] isEqualToString:@"date"]) {
    [bookingDatePicker setMinimumDate:[NSDate date]];
    [bookingDatePicker setMinuteInterval:15];
    [textField setInputView:bookingDatePicker];
    [bookingDatePicker release];
  } else if ([[field type] isEqualToString:@"number"]) {
    [textField setInputView:bookingPartyPicker];
    [bookingPartyPicker release];
  } else if ([[field type] isEqualToString:@"phone"]) {
      [textField setKeyboardType:UIKeyboardTypeNumberPad];
  } else if ([[field type] isEqualToString:@"email"]) {
      [textField setKeyboardType:UIKeyboardTypeEmailAddress];
  } else {
      [textField setKeyboardType:UIKeyboardTypeDefault];
  }
  
  [[cell textLabel] setText:[field name]];
    
  [cell addSubview:textField];
  // release the text field but DO NOT release the field. We don't own it, we're not assigning it. And it makes things go WRONG.
  [textField release];
  return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  [[cell textLabel] setTextColor:[UIColor lightTextColor]];
  [[cell textLabel] setBackgroundColor:[UIColor clearColor]];  
  [[cell textLabel] setFont:[UIFont systemFontOfSize:14.0]];
  
  [cell setBackgroundColor:[UIColor colorWithRed:56.0/255.0 green:51.0/255.0 blue:44.0/255.0 alpha:0.75]]; 
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

#pragma mark - Keyboard Actions
- (void)didDismissKeyboard:(id)sender {
  [bookingData setValue:[currentActiveField text] forKey:[currentActiveField identifier]];
  [currentActiveField resignFirstResponder];
}

- (void)didSelectNextInput:(id)sender {
  UIResponder *nextResponder = [[self tableView] viewWithTag:[currentActiveField tag]+1];
  [bookingData setValue:[currentActiveField text] forKey:[currentActiveField identifier]];
  
  if (nextResponder) {
    [nextResponder becomeFirstResponder];
  }
}

- (void)didSelectPreviousInput:(id)sender {
  UIResponder *prevResponder = [[self tableView] viewWithTag:[currentActiveField tag]-1];
  [bookingData setValue:[currentActiveField text] forKey:[currentActiveField identifier]];
  if (prevResponder) {
    [prevResponder becomeFirstResponder];
  }
}

- (void)didTapSaveButton:(UIButton *)button {
  [bookingData persist];
}

#pragma mark - Table View Headers/Footers

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)] autorelease];
        
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(30, 20, 260, 40)] autorelease];
    [button setTitle:@"Make Booking" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:41.0/255.0 green:23.0/255.0 blue:0.0/255.0 alpha:1] forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:18]];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"submit-2.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setOpaque:YES];
    
    [button addTarget:self 
               action:@selector(didTapSaveButton:) 
     forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:button];
    return footer;
}

#pragma mark - Text View Delegates
- (BOOL)textFieldShouldReturn:(BookingFormTextField *)textField {  
  [bookingData setValue:[currentActiveField text] forKey:[currentActiveField identifier]];
  [currentActiveField setText:[currentActiveField text]];
  NSInteger nextTag = [currentActiveField tag]+1;
  // Try to find next responder
  UIResponder* nextResponder = [[self tableView] viewWithTag:nextTag];

  if (nextResponder) {
    // Found next responder, so set it.
    [nextResponder becomeFirstResponder];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:nextTag inSection:0];
    [[self tableView] scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
  } else {
    // Not found, so remove keyboard.
    [currentActiveField resignFirstResponder];
  }

  return YES; // We do not want UITextField to insert line-breaks.
}

-(void)textFieldDidBeginEditing:(BookingFormTextField *)textField {
  currentActiveField = textField;
}

#pragma mark - UI Picker View Delegates/DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return (bookingPickerMaxPartySize - bookingPickerMinPartySize + 1);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return [NSString stringWithFormat:@"%d", (row + bookingPickerMinPartySize)];
}

// gotta duplicate a liiiiittle bit of code, but nay mind.
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  [currentActiveField setText:[NSString stringWithFormat:@"%d", (bookingPickerMinPartySize + row)]];
}

#pragma mark - UI Date Picker View Methodage
- (IBAction)bookingDatePickerSelectedDate:(UIDatePicker *)datePicker {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"d-L-y h:mm a"];
  [currentActiveField setText:[dateFormatter stringFromDate:[datePicker date]]];
  [dateFormatter release];
}

#pragma mark - Some overrides for editing
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

@end
