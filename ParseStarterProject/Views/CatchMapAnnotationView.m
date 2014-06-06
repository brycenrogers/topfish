//
//  CatchMapAnnotationView.m
//  TopFish
//
//  Created by Brycen Rogers on 5/18/14.
//
//

#import "CatchMapAnnotationView.h"
#import <MapKit/MapKit.h>

@implementation CatchMapAnnotationView

@synthesize selectedCatch;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier catch:(Catch *)catch
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.canShowCallout = YES;
        self.selectedCatch = catch;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        self.rightCalloutAccessoryView = rightButton;
        
        PFImageView *fishPhotoImageView = [[PFImageView alloc] init];
        fishPhotoImageView.image = [UIImage imageNamed:@"fish-default-photo.png"];
        fishPhotoImageView.file = catch.photo;
        [fishPhotoImageView loadInBackground];
        fishPhotoImageView.frame = CGRectMake(0, 0, 40.0, 30.0);
        fishPhotoImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.leftCalloutAccessoryView = fishPhotoImageView;
        self.image = [UIImage imageNamed:@"fish-pin.png"];
        self.calloutOffset = CGPointMake(1, 0);
        
        self.alpha = 0.5;
    }
    return self;
}

- (void)setRightCalloutAccessoryViewSelector:(SEL)selector
{
    UIButton *rightCalloutButton = (UIButton *)self.rightCalloutAccessoryView;
    [rightCalloutButton addTarget:nil action:selector forControlEvents:UIControlEventTouchUpInside];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
