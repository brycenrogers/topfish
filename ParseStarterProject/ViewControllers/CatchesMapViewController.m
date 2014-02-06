//
//  CatchesMapViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/3/13.
//
//

#import "CatchesMapViewController.h"
#import <Parse/Parse.h>
#import "Catch.h"
#import "CatchMapAnnotation.h"

@interface CatchesMapViewController ()

@end

@implementation CatchesMapViewController

@synthesize mapView, selectedGeopoint, catches;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    currentUserLocation = kCLLocationCoordinate2DInvalid;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (!CLLocationCoordinate2DIsValid(currentUserLocation)) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 18000, 18000);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        [self placeCatchAnnotationOnMap:self.mapView.userLocation.coordinate];
        self.selectedGeopoint = [PFGeoPoint geoPointWithLocation:userLocation.location];
        currentUserLocation = userLocation.coordinate;
    }
}

- (void)placeCatchAnnotationOnMap:(CLLocationCoordinate2D)coordinate {
    CatchMapAnnotation *catchAnnot = [[CatchMapAnnotation alloc] init];
    catchAnnot.coordinate = coordinate;
    catchAnnot.animatesDrop = NO;
    //[self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:catchAnnot];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView*pinView=nil;
    if(annotation != self.mapView.userLocation)
    {
        static NSString *defaultPin = @"AddCatchMapAnnotation";
        pinView=(MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPin];
        if(pinView==nil)
            pinView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:defaultPin];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = NO;
    }
    else
    {
        [self.mapView.userLocation setTitle:@"You are Here!"];
    }
    return pinView;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if (self.selectedGeopoint != nil) {
        PFQuery *query = [Catch query];
        [query whereKey:@"location" nearGeoPoint:self.selectedGeopoint];
        query.limit = 50;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            self.catches = objects;
            [self updateCatchesOnMap];
        }];
    }
}

- (void)updateCatchesOnMap {
    [self.mapView removeAnnotations:self.mapView.annotations];
    if (self.catches == nil) {
        return;
    }
    for (Catch *catchObject in self.catches) {
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(catchObject.location.latitude, catchObject.location.longitude);
        [self placeCatchAnnotationOnMap:loc];
    }
}

@end
