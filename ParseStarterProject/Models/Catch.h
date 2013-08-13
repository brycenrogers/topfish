//
//  Catch.h
//  TopFish
//
//  Created by Brycen Rogers on 8/10/13.
//
//

#import <Parse/Parse.h>

@interface Catch : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (retain) NSString *name;
@property int length;
@property int weight;
@property (retain) NSString *lengthMeasurement;
@property (retain) NSString *weightMeasurement;
@property (retain) PFUser *user;

@end
