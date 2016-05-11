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
#import "CatchDetailTableViewController.h"
#import "CatchMapAnnotationView.h"
#import "FilterTableViewController.h"

@interface CatchesMapViewController ()

@end

@implementation CatchesMapViewController

@synthesize mapView,
selectedGeopoint,
catches,
selectedCatch,
filteredLayer,
selectedMethodFilter,
selectedSpeciesFilter;

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
    
    // Filter icon
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(262.0, 43.0) radius:4.0 startAngle:0 endAngle:M_PI * 2.0 clockwise:YES];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = [path CGPath];
    layer.fillColor = [[UIColor whiteColor] CGColor];
    layer.opacity = 0.0;
    self.filteredLayer = layer;
    [self.navigationController.view.layer addSublayer:self.filteredLayer];
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.selectedMethodFilter != nil || self.selectedSpeciesFilter != nil) {
        [self showFilteredLayer];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self hideFilteredLayer];
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
        self.selectedGeopoint = [PFGeoPoint geoPointWithLocation:userLocation.location];
        currentUserLocation = userLocation.coordinate;
    }
}

- (void)placeCatchAnnotationOnMap:(Catch *)catch {
    
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(catch.location.latitude, catch.location.longitude);
    CatchMapAnnotation *catchAnnot = [[CatchMapAnnotation alloc] init];
    catchAnnot.coordinate = loc;
    [catchAnnot setTitle:catch.species];
    [catchAnnot setSubtitle:catch.user.username];
    catchAnnot.catch = catch;
    
    [self.mapView addAnnotation:catchAnnot];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *defaultPin = @"AddCatchMapAnnotation";
    CatchMapAnnotationView *pinView = nil;
    CatchMapAnnotation *annot = (CatchMapAnnotation *)annotation;
    if (!pinView) {
        if(annotation != self.mapView.userLocation)
        {
            pinView = (CatchMapAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPin];
            
            if (pinView == nil) {
                pinView = [[CatchMapAnnotationView alloc] initWithAnnotation:annot reuseIdentifier:defaultPin catch:annot.catch];
            }
            
            [pinView setRightCalloutAccessoryViewSelector:@selector(showCatchDetail)];
        }
        else
        {
            [self.mapView.userLocation setTitle:@"You are Here!"];
        }
    }
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view isKindOfClass:[CatchMapAnnotationView class]]) {
        CatchMapAnnotationView *selectedView = (CatchMapAnnotationView *)view;
        selectedCatch = selectedView.selectedCatch;
        
        [UIView animateWithDuration:.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            selectedView.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if ([view isKindOfClass:[CatchMapAnnotationView class]]) {
        CatchMapAnnotationView *selectedView = (CatchMapAnnotationView *)view;
        [UIView animateWithDuration:.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            selectedView.alpha = 0.5;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)showCatchDetail
{
    [self performSegueWithIdentifier:@"showCatchDetailSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCatchDetailSegue"])
    {
        
        CatchDetailTableViewController *catchDetailVC = [segue destinationViewController];
        catchDetailVC.selectedCatch = selectedCatch;
        return;
    }
    
    if ([[segue identifier] isEqualToString:@"showFilterSegue"])
    {
        FilterTableViewController *filterTVC = [segue destinationViewController];
        filterTVC.delegate = self;
        return;
    }
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if (self.selectedGeopoint != nil) {
        [self updateCatchesOnMap];
    }
}

- (void)loadObjects
{
    [self updateCatchesOnMap];
}

- (void)updateCatchesOnMap {
    PFQuery *query = [Catch query];
    [query includeKey:@"user"];
    [query whereKey:@"location" nearGeoPoint:self.selectedGeopoint];
    if (selectedSpeciesFilter != nil) {
        [query whereKey:@"species" equalTo:self.selectedSpeciesFilter];
    }
    if (selectedMethodFilter != nil) {
        [query whereKey:@"method" equalTo:self.selectedMethodFilter];
    }
    query.limit = 50;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.catches = objects;
        [self.mapView removeAnnotations:self.mapView.annotations];
        if (self.catches == nil) {
            return;
        }
        for (Catch *catchObject in self.catches) {
            [self placeCatchAnnotationOnMap:catchObject];
        }
    }];
}

- (void)updateLeaderboardWithFilter {
    [self updateCatchesOnMap];
}

- (void)showFilteredLayer {
    [self.filteredLayer setOpacity:1.0];
}

- (void)hideFilteredLayer {
    [self.filteredLayer setOpacity:0.0];
}

- (void)setFilterButtonColor:(UIColor *)toColor {
    [self.filterButton setTitleTextAttributes:@{NSForegroundColorAttributeName: toColor} forState:UIControlStateNormal];
}

@end
