//
//  AddCatchMapLocationViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 8/25/13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CatchMapAnnotation.h"
#import "AddCatchInfoTableViewController.h"
#import "CatchMapDelegate.h"

@interface AddCatchMapLocationViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) UITableViewController<CatchMapDelegate> *delegate;
@property (nonatomic) CLLocationCoordinate2D locationCoordinate;
@property (weak, nonatomic) CatchMapAnnotation *catchAnnotation;
@property (nonatomic) BOOL canDropAnnotation;
@property (strong, nonatomic) IBOutlet UILabel *holdToDropPinLabel;

- (IBAction)doneButton:(UIBarButtonItem *)sender;

@end