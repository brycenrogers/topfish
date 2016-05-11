//
//  CatchMapAnnotation.m
//  TopFish
//
//  Created by Brycen Rogers on 8/26/13.
//
//

#import "CatchMapAnnotation.h"
#import "CatchMapAnnotationView.h"

@implementation CatchMapAnnotation

@synthesize calloutView, catch;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;
    return;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    return;
}

- (void)setSubtitle:(NSString *)subtitle {
    _subtitle = subtitle;
    return;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
}

@end
