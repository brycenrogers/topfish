//
//  AddCatchMapLocationViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 8/25/13.
//
//

#import "AddCatchMapLocationViewController.h"
#import "CatchMapAnnotation.h"
#import "AddCatchInfoTableViewController.h"
#import "CustomTabBarController.h"

#define METERS_PER_MILE 1609.344

@interface AddCatchMapLocationViewController ()

@end

@implementation AddCatchMapLocationViewController

@synthesize delegate, catchAnnotation, locationCoordinate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup longpress gesture recognizer
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longpress.minimumPressDuration = 0.75;
    [self.mapView addGestureRecognizer:longpress];
    
    self.mapView.delegate = self;
}

- (void)placeSelectedCatchAnnotationOnMap {
    // This places a Catch Annotation set from the Parent VC on the mapView
    if (self.locationCoordinate.latitude == 90.0 && self.locationCoordinate.longitude == 0.0) {
        return;
    }
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.locationCoordinate, 1200, 1200);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    [self placeCatchAnnotationOnMap:self.locationCoordinate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.locationCoordinate.longitude == 0 && self.locationCoordinate.latitude == 0) {
        self.locationCoordinate = kCLLocationCoordinate2DInvalid;
    }
    
    if (CLLocationCoordinate2DIsValid(self.locationCoordinate) &&
        self.catchAnnotation == nil) {
        [self placeSelectedCatchAnnotationOnMap];
    }
}

- (IBAction)doneButton:(UIBarButtonItem *)sender {
    
    self.delegate.catchAnnotationCoordinate = locationCoordinate;
    if (self.catchAnnotation == nil) {
        [self.delegate changeLocationFieldIconToColor:@"grey"];
    } else {
        [self.delegate changeLocationFieldIconToColor:@"blue"];
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (CLLocationCoordinate2DIsValid(self.locationCoordinate) == NO) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 1200, 1200);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        [self placeCatchAnnotationOnMap:self.mapView.userLocation.coordinate];
    }
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
    {
        return;
    }
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    [self placeCatchAnnotationOnMap:touchMapCoordinate];
}

- (void)placeCatchAnnotationOnMap:(CLLocationCoordinate2D)coordinate {    
    CatchMapAnnotation *catchAnnot = [[CatchMapAnnotation alloc] init];
    catchAnnot.coordinate = coordinate;
    catchAnnot.animatesDrop = YES;
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:catchAnnot];
    self.locationCoordinate = CLLocationCoordinate2DMake(catchAnnot.coordinate.latitude, catchAnnot.coordinate.longitude);
    self.catchAnnotation = catchAnnot;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    if(annotation != self.mapView.userLocation)
    {
        static NSString *defaultPin = @"AddCatchMapAnnotation";
        pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPin];
        if(pinView == nil) {
            pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:defaultPin];
        }
        pinView.image = [UIImage imageNamed:@"fish-pin.png"];
    }
    else
    {
        [self.mapView.userLocation setTitle:@"You are Here!"];
    }
    return pinView;
}

@end
