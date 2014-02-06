//
//  CatchMapDelegate.h
//  TopFish
//
//  Created by Brycen Rogers on 1/5/14.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol CatchMapDelegate <NSObject>

@property (nonatomic) CLLocationCoordinate2D catchAnnotationCoordinate;

@end
