//
//  BookingFormField.h
//  YourRestaurant
//
//  Created by Lee Machin on 19/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookingFormField : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *type;
@property (nonatomic) BOOL editable;

@end
