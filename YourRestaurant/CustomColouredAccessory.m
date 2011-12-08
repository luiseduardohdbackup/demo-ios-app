//
//  CustomColouredAccessory.m
//  YourRestaurant
//
//  Created by Lee Machin on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomColouredAccessory.h"

@implementation CustomColouredAccessory
@synthesize accessoryColour = _accessoryColour;
@synthesize highlightedColour = _highlightedColour;

- (id) initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

- (void) dealloc {
  [_accessoryColour release];
  [_highlightedColour release];
  [super dealloc];
}

+ (CustomColouredAccessory *)accessoryWithColour:(UIColor *)colour {
  CustomColouredAccessory *ret = [[[CustomColouredAccessory alloc] 
                                   initWithFrame:CGRectMake(0, 0, 11, 15)] 
                                  autorelease];
  [ret setAccessoryColour:colour];
  return ret;
}

- (void) drawRect:(CGRect)rect {
  // (x, y) is tip of arrow
  CGFloat x = CGRectGetMaxX([self bounds]) - 3;
  CGFloat y = CGRectGetMidY([self bounds]);
  
  const CGFloat R = 4.5;
  
  CGContextRef ctxt = UIGraphicsGetCurrentContext();
  CGContextMoveToPoint(ctxt, x-R, y-R);
  CGContextAddLineToPoint(ctxt, x, y);
  CGContextAddLineToPoint(ctxt, x-R, y+R);
  CGContextSetLineCap(ctxt, kCGLineCapSquare);
  CGContextSetLineJoin(ctxt, kCGLineJoinMiter);
  CGContextSetLineWidth(ctxt, 3);
  
  if (self.highlighted) {
    [[self highlightedColour] setStroke];
  } else {
    [[self accessoryColour] setStroke];
  }
  
  CGContextStrokePath(ctxt);
}

- (void) setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  [self setNeedsDisplay];
}

- (UIColor *)accessoryColour {
  if (!_accessoryColour) { 
    return [UIColor blackColor];
  }
  
  return _accessoryColour;
}

- (UIColor *)highlightedColour {
  if (!_highlightedColour) {
    return [UIColor whiteColor];
  }
  
  return _highlightedColour;
}
@end
