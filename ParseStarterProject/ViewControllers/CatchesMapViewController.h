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
#import "FishingFilterProtocol.h"

@interface CatchesMapViewController : UIViewController<MKMapViewDelegate, FishingFilterProtocol>
{
    CLLocationCoordinate2D currentUserLocation;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) PFGeoPoint *selectedGeopoint;
@property (strong, nonatomic) NSArray *catches;
@property (strong, nonatomic) Catch *selectedCatch;
@property (nonatomic) NSString *selectedMethodFilter;
@property (nonatomic) NSString *selectedSpeciesFilter;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterButton;
@property (nonatomic, strong) CAShapeLayer *filteredLayer;

- (void)updateLeaderboardWithFilter;
- (void)setFilterButtonColor:(UIColor *)toColor;
- (void)showFilteredLayer;
- (void)hideFilteredLayer;

@end
