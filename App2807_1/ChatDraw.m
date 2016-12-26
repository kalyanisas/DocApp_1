//
//  ChatDraw.m
//  App2807_1
//
//  Created by Kalyani on 20/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "ChatDraw.h"

@implementation ChatDraw

-(void)drawRect:(CGRect)rect
{
    NSString *doseStr = [NSString stringWithFormat:@"Hello Doc ...how r u?"];
    unsigned long width = doseStr.length *5;

    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor ].CGColor);
    
    CGContextFillRect(context, CGRectMake(0,0,self.frame.size.width,self.frame.size.height));
    
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillRect(context, CGRectMake(0,0,width,20));
    
    
    
    [doseStr drawAtPoint:CGPointMake(1, 1) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica"  size:10]}];
    
    const CGFloat outlineStrokeWidth = 20.0f;
    const CGFloat outlineCornerRadius = 15.0f;
    
    const CGColorRef whiteColor = [[UIColor whiteColor] CGColor];
    const CGColorRef redColor = [[UIColor redColor] CGColor];
    
    // get the context
    
    // set the background color to white
    CGContextSetFillColorWithColor(context, whiteColor);
    CGContextFillRect(context, rect);
    
    // inset the rect because half of the stroke applied to this path will be on the outside
    CGRect insetRect = CGRectInset(rect, outlineStrokeWidth/2.0f, outlineStrokeWidth/2.0f);
    
    // get our rounded rect as a path
 //   CGMutablePathRef *path = createRoundedCornerPath(insetRect, outlineCornerRadius);
    
    // add the path to the context
//    CGContextAddPath(context, path);
    
    // set the stroke params
    CGContextSetStrokeColorWithColor(context, redColor);
    CGContextSetLineWidth(context, outlineStrokeWidth);
    
    // draw the path
    CGContextDrawPath(context, kCGPathStroke);
    
    
}


@end



