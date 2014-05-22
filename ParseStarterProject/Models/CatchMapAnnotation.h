//
//  CatchMapAnnotation.h
//  TopFish
//
//  Created by Brycen Rogers on 8/26/13.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Catch.h"

@interface CatchMapAnnotation : MKPinAnnotationView<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, strong) UIView *calloutView;
@property (nonatomic, strong) Catch *catch;
@property (nonatomic, strong) UIImageView *catchImageView;

- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;

@end
