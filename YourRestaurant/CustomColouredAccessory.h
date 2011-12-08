//
//  CustomColouredAccessory.h
//  YourRestaurant
//
//  Created by Lee Machin on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomColouredAccessory : UIControl {
  UIColor *_accessoryColour;
  UIColor *_highlightedColour;
}

@property (nonatomic, retain) UIColor *accessoryColour;
@property(nonatomic, retain) UIColor *highlightedColour;

+ (CustomColouredAccessory *)accessoryWithColour:(UIColor *)colour;

@end
