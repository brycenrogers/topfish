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

@interface AddCatchMapLocationViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) AddCatchInfoTableViewController *delegate;
@property (weak, nonatomic) CatchMapAnnotation *catchAnnotation;

- (IBAction)doneButton:(UIBarButtonItem *)sender;

@end