//
//  CustomNavBar.m
//  YourRestaurant
//
//  Created by Lee Machin on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

- (void) drawRect:(CGRect)rect {
  UIImage *image = [UIImage imageNamed:@"navigation.png"];
  [image drawInRect:CGRectMake(0,
                               0, 
                               self.frame.size.width, 
                               self.frame.size.height)];
}

@end
