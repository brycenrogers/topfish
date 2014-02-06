//
//  CatchesMapViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/3/13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CatchMapAnnotation.h"
#import <Parse/Parse.h>

@interface CatchesMapViewController : UIViewController<MKMapViewDelegate>
{
    CLLocationCoordinate2D currentUserLocation;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) PFGeoPoint *selectedGeopoint;
@property (strong, nonatomic) NSArray *catches;

@end
