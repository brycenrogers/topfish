//
//  CatchMapAnnotationView.h
//  TopFish
//
//  Created by Brycen Rogers on 5/18/14.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Catch.h"

@interface CatchMapAnnotationView : MKAnnotationView

@property (nonatomic, strong) Catch *selectedCatch;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier catch:(Catch *)catch;
- (void)setRightCalloutAccessoryViewSelector:(SEL)selector;

@end
