//
//  CatchMapAnnotation.h
//  TopFish
//
//  Created by Brycen Rogers on 8/26/13.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CatchMapAnnotation : MKPinAnnotationView<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;

@end
