//
//  BookingFormModel.h
//  YourRestaurant
//
//  Created by Lee Machin on 20/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface BookingFormModel : NSObject <ASIHTTPRequestDelegate> {
  id delegate;
}

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *emailAddress;
@property (nonatomic, copy) NSString *partySize;
@property (nonatomic, copy) NSString *bookingDate;
@property (nonatomic, assign, getter = isDirty) BOOL dirty;
@property (nonatomic, assign) id delegate;

- (void)persist;
- (void)persistLocally;

@end

@protocol BookingFormModelDelegate <NSObject>

@end
