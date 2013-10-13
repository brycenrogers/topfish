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

@synthesize delegate, catchAnnotation;

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
    
    // Step back through the view heirarchy and assign the parent VC to the current VC for use later
    //[self bindParentVC];
}

- (void)placeSelectedCatchAnnotationOnMap {
    // This places a Catch Annotation set from the Parent VC on the mapView
    if (self.delegate.catchAnnotationCoordinate.latitude == 90.0 && self.delegate.catchAnnotationCoordinate.longitude == 0.0) {
        return;
    }
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.delegate.catchAnnotationCoordinate, 1200, 1200);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    [self placeCatchAnnotationOnMap:self.delegate.catchAnnotationCoordinate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (CLLocationCoordinate2DIsValid(self.delegate.catchAnnotationCoordinate) && self.catchAnnotation == nil) {
        [self placeSelectedCatchAnnotationOnMap];
    }
}

- (IBAction)doneButton:(UIBarButtonItem *)sender {
    NSString *coordString = [[NSString alloc] initWithFormat:@"Lat. %f, Long. %f",
                             self.delegate.catchAnnotationCoordinate.latitude,
                             self.delegate.catchAnnotationCoordinate.longitude];
    self.delegate.selectedLocationLabel.text = coordString;
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (CLLocationCoordinate2DIsValid(self.delegate.catchAnnotationCoordinate) == NO) {
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
    self.delegate.catchAnnotationCoordinate = CLLocationCoordinate2DMake(catchAnnot.coordinate.latitude, catchAnnot.coordinate.longitude);
    self.catchAnnotation = catchAnnot;
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
        pinView.animatesDrop = YES;
    }
    else
    {
        [self.mapView.userLocation setTitle:@"You are Here!"];
    }
    return pinView;
}

@end
