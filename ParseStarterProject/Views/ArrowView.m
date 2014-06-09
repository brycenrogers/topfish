//
//  ArrowView.m
//  TopFish
//
//  Created by Brycen Rogers on 6/7/14.
//
//

#import "ArrowView.h"

@implementation ArrowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self drawArrowWithContext:UIGraphicsGetCurrentContext()
                       atPoint:CGPointMake(50, 50)
                      withSize:CGSizeMake(40, 100)
                     lineWidth:1.0f
                   arrowHeight:100];
}

// Draw arrow

- (void) drawArrowWithContext:(CGContextRef)context
                      atPoint:(CGPoint)startPoint
                     withSize:(CGSize)size
                    lineWidth:(float)width
                  arrowHeight:(float)aheight
{
    float width_wing = (size.width-width)/2;
    float main = size.height-aheight;
    CGPoint rectangle_points[] =
    {
        CGPointMake(startPoint.x + width_wing, startPoint.y + 0.0),
        CGPointMake(startPoint.x + width_wing, startPoint.y + main),
        CGPointMake(startPoint.x + 0.0, startPoint.y + main), // left point
        CGPointMake(startPoint.x + size.width/2, startPoint.y + size.height),
        
        CGPointMake(startPoint.x + size.width, startPoint.y + main), // right point
        
        CGPointMake(startPoint.x + size.width-width_wing, startPoint.y + main),
        
        CGPointMake(startPoint.x + size.width-width_wing, startPoint.y + 0.0),
        CGPointMake(startPoint.x + width_wing, startPoint.y + 0.0),
    };
    
    CGContextAddLines(context, rectangle_points, 8);
    
    CGContextFillPath(context);
}

@end
