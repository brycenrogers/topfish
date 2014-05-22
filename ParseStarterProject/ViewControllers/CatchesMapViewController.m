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
        //[self placeCatchAnnotationOnMap:self.mapView.userLocation.coordinate withImageView:nil];
        self.selectedGeopoint = [PFGeoPoint geoPointWithLocation:userLocation.location];
        currentUserLocation = userLocation.coordinate;
    }
}

- (void)placeCatchAnnotationOnMap:(Catch *)catch {
    
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(catch.location.latitude, catch.location.longitude);
    CatchMapAnnotation *catchAnnot = [[CatchMapAnnotation alloc] init];
    catchAnnot.coordinate = loc;
    [catchAnnot setTitle:catch.species];
    catchAnnot.catch = catch;
    
    [self.mapView addAnnotation:catchAnnot];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *defaultPin = @"AddCatchMapAnnotation";
    MKPinAnnotationView *pinView = nil;
    CatchMapAnnotation *annot = (CatchMapAnnotation *)annotation;
    if (!pinView) {
        if(annotation != self.mapView.userLocation)
        {
            pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPin];
            
            if (pinView == nil) {
                pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annot reuseIdentifier:defaultPin];
            }
            
            pinView.pinColor = MKPinAnnotationColorRed;
            pinView.canShowCallout = YES;
            pinView.animatesDrop = NO;
            
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            pinView.rightCalloutAccessoryView = rightButton;
            
            PFImageView *fishPhotoImageView = [[PFImageView alloc] init];
            fishPhotoImageView.image = [UIImage imageNamed:@"fish-default-photo.png"]; // placeholder image
            fishPhotoImageView.file = annot.catch.photo;
            [fishPhotoImageView loadInBackground];
            fishPhotoImageView.frame = CGRectMake(0, 0, 30.0, 30.0);
            
            pinView.leftCalloutAccessoryView = fishPhotoImageView;
        }
        else
        {
            [self.mapView.userLocation setTitle:@"You are Here!"];
        }
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
        [self placeCatchAnnotationOnMap:catchObject];
    }
}

@end
