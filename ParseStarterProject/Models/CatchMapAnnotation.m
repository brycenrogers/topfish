//
//  CatchMapAnnotation.m
//  TopFish
//
//  Created by Brycen Rogers on 8/26/13.
//
//

#import "CatchMapAnnotation.h"

@implementation CatchMapAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;
    return;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    return;
}

@end
